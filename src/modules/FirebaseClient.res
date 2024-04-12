/* *****************************************************************************
 * FirebaseClient
 */

open Types

let gamesKeyPrefix = "/games/"

/* ************************************************************************
 * Functions
 */

let getPhase = (page: page, step: scenarioStep): PhaseCodec.t => {
  switch (page, step) {
  | (Title, _) => #DaytimeWaiting
  | (Setup, _) => #DaytimeWaiting
  | (SetupLanguage, _) => #DaytimeWaiting
  | (SetupMusic, _) => #DaytimeWaiting
  | (SetupPlayers, _) => #DaytimeWaiting
  | (SetupNetwork, _) => #DaytimeWaiting
  | (Credits, _) => #DaytimeWaiting
  | (Daytime, _) => #DaytimeWaiting
  | (DaytimeWaiting, _) => #DaytimeWaiting
  | (DaytimeConfess, _) => #DaytimeWaiting
  | (DaytimeReveal, _) => #DaytimeWaiting
  | (DaytimeRevealNoConfess, _) => #DaytimeWaiting
  | (Close, _) => #DaytimeWaiting
  | (_, ChooseWitches) => #NightChoiceWitches
  | (_, ConfirmWitches) => #NightConfirmWitches
  | (_, ChooseConstable) => #NightChoiceConstable
  | (_, ConfirmConstable) => #NightConfirmConstable
  | (_, _) => #NightWaiting
  }
}

let getPage = (phase: PhaseCodec.t): page => {
  switch phase {
  | #DaytimeWaiting => DaytimeWaiting
  | #NightWaiting => NightWaiting
  | #NightChoiceWitches => NightChoiceWitches
  | #NightConfirmWitches => NightConfirmWitches
  | #NightChoiceConstable => NightChoiceConstable
  | #NightConfirmConstable => NightConfirmConstable
  }
}

let transformToDbRecord = (
  gameState: gameState,
  currentPage: page,
  turnState: turnState,
  scenarioStep: scenarioStep,
): dbRecord => {
  {
    masterGameId: gameState.gameType->Utils.ifMasterGetGameId,
    masterLanguage: gameState.language,
    masterPhase: getPhase(currentPage, scenarioStep),
    masterPlayers: gameState.players,
    masterSeating: gameState.seating,
    masterNumberWitches: turnState.nrWitches,
    masterNightType: turnState.nightType,
    masterHasGhostPlayers: gameState.hasGhostPlayers,
    slaveChoiceWitches: turnState.choiceWitches,
    slaveChoiceConstable: turnState.choiceConstable,
    slaveConfirmWitches: #Unconfirmed,
    slaveConfirmConstable: #Unconfirmed,
    updatedAt: Js.Date.make()->Js.Date.toISOString,
  }
}

/* ************************************************************************
 * connect/disconnect: forward to adapter
 */

let connect = (): promise<dbConnection> => {
  FirebaseAdapter.connect()
}

let disconnect = (dbConnection: dbConnection): unit => {
  FirebaseAdapter.disconnect(dbConnection)
}

/* ************************************************************************
 * join/leave (Slave): forward to adapter
 */

let joinGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): bool => {
  FirebaseAdapter.joinGame(dbConnection, gameId)
}

let leaveGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): unit => {
  FirebaseAdapter.leaveGame(dbConnection, gameId)
}

/* ************************************************************************
 * create/update/delete (Master)
 */

let createGame = (dbConnection: dbConnection, gameState: gameState): promise<unit> => {
  let emptyTurnState: turnState = {
    nrWitches: One,
    nightType: Dawn,
    choiceWitches: PlayerCodec.Undecided,
    choiceConstable: PlayerCodec.Undecided,
  }
  let dbRecord = transformToDbRecord(gameState, Title, emptyTurnState, Pause(0.))
  FirebaseAdapter.writeGame(dbConnection, dbRecord, "Created")
}

let updateGame = (
  dbConnection: dbConnection,
  gameState: gameState,
  currentPage: page,
  turnState: turnState,
  maybeScenarioStep: option<scenarioStep>,
): promise<unit> => {
  let dbRecord = transformToDbRecord(
    gameState,
    currentPage,
    turnState,
    maybeScenarioStep->Belt.Option.getWithDefault(Pause(0.)),
  )
  FirebaseAdapter.writeGame(dbConnection, dbRecord, "Updated")
}

let updateGameKey = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
  value: string,
): promise<unit> => {
  FirebaseAdapter.writeGameKey(dbConnection, gameId, subject, value)
}

let deleteGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): unit => {
  FirebaseAdapter.deleteGame(dbConnection, gameId)
}

let saveGameState = (
  dbConnection: dbConnection,
  gameState: gameState,
  page: page,
  turnState: turnState,
  maybeScenarioStep: option<scenarioStep>,
): unit => {
  updateGame(dbConnection, gameState, page, turnState, maybeScenarioStep)->Utils.catchLogAndIgnore()
}

let saveGameTurnState = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  nightType: string,
  nrWitches: string,
  choiceWitches: string,
  choiceConstable: string,
): unit => {
  Promise.all([
    updateGameKey(dbConnection, gameId, MasterNightTypeSubject, nightType),
    updateGameKey(dbConnection, gameId, MasterNumberWitchesSubject, nrWitches),
    updateGameKey(dbConnection, gameId, ChoiceWitchesSubject, choiceWitches),
    updateGameKey(dbConnection, gameId, ChoiceConstableSubject, choiceConstable),
  ])->Utils.catchLogAndIgnore([])
}

let saveGameNightType = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  nightType: NightTypeCodec.t,
) => {
  updateGameKey(
    dbConnection,
    gameId,
    MasterNightTypeSubject,
    nightType->NightTypeCodec.nightTypeToString,
  )->Utils.catchLogAndIgnore()
}

let saveGameConfirmation = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
  confirmation: DecisionCodec.t,
) => {
  updateGameKey(
    dbConnection,
    gameId,
    subject,
    confirmation->DecisionCodec.decisionToJs,
  )->Utils.catchLogAndIgnore()
}

let saveGameConfirmations = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  confirmWitches: DecisionCodec.t,
  confirmConstable: DecisionCodec.t,
): unit => {
  Promise.all([
    updateGameKey(
      dbConnection,
      gameId,
      ConfirmWitchesSubject,
      confirmWitches->DecisionCodec.decisionToJs,
    ),
    updateGameKey(
      dbConnection,
      gameId,
      ConfirmConstableSubject,
      confirmConstable->DecisionCodec.decisionToJs,
    ),
  ])->Utils.catchLogAndIgnore([])
}

let saveGamePhase = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  page: page,
  maybeScenarioStep: option<scenarioStep>,
): unit => {
  let scenarioStep = maybeScenarioStep->Belt.Option.getWithDefault(Pause(0.))
  let phase = getPhase(page, scenarioStep)->PhaseCodec.phaseToJs
  updateGameKey(dbConnection, gameId, MasterPhaseSubject, phase)->Utils.catchLogAndIgnore()
}

/* ************************************************************************
 * listen (Master)
 */

let listen = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
  callback: option<string> => unit,
): unit => {
  FirebaseAdapter.listen(dbConnection, gameId, subject, callback)
}

let stopListening = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
): unit => {
  FirebaseAdapter.stopListening(dbConnection, gameId, subject)
}
