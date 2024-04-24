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
  | (Title, _) => DaytimeWaitingPhase
  | (Setup, _) => DaytimeWaitingPhase
  | (SetupLanguage, _) => DaytimeWaitingPhase
  | (SetupMusic, _) => DaytimeWaitingPhase
  | (SetupPlayers, _) => DaytimeWaitingPhase
  | (SetupNetwork, _) => DaytimeWaitingPhase
  | (Credits, _) => DaytimeWaitingPhase
  | (Daytime, _) => DaytimeWaitingPhase
  | (DaytimeWaiting, _) => DaytimeWaitingPhase
  | (DaytimeConfess, _) => DaytimeWaitingPhase
  | (DaytimeReveal, _) => DaytimeWaitingPhase
  | (DaytimeRevealNoConfess, _) => DaytimeWaitingPhase
  | (Close, _) => DaytimeWaitingPhase
  | (_, ChooseWitches) => NightChoiceWitchesPhase
  | (_, ConfirmWitches) => NightConfirmWitchesPhase
  | (_, ChooseConstable) => NightChoiceConstablePhase
  | (_, ConfirmConstable) => NightConfirmConstablePhase
  | (_, _) => NightWaitingPhase
  }
}

let getPage = (phase: PhaseCodec.t): page => {
  switch phase {
  | DaytimeWaitingPhase => DaytimeWaiting
  | NightWaitingPhase => NightWaiting
  | NightChoiceWitchesPhase => NightChoiceWitches
  | NightConfirmWitchesPhase => NightConfirmWitches
  | NightChoiceConstablePhase => NightChoiceConstable
  | NightConfirmConstablePhase => NightConfirmConstable
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
    slaveConfirmWitches: Unconfirmed,
    slaveConfirmConstable: Unconfirmed,
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
  value: Js.Json.t,
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
  nightType: NightTypeCodec.t,
  nrWitches: NumerusCodec.t,
  choiceWitches: PlayerCodec.t,
  choiceConstable: PlayerCodec.t,
): unit => {
  Promise.all([
    updateGameKey(dbConnection, gameId, MasterNightTypeSubject, nightType->NightTypeCodec.t_encode),
    updateGameKey(
      dbConnection,
      gameId,
      MasterNumberWitchesSubject,
      nrWitches->NumerusCodec.t_encode,
    ),
    updateGameKey(dbConnection, gameId, ChoiceWitchesSubject, choiceWitches->PlayerCodec.t_encode),
    updateGameKey(
      dbConnection,
      gameId,
      ChoiceConstableSubject,
      choiceConstable->PlayerCodec.t_encode,
    ),
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
    nightType->NightTypeCodec.t_encode,
  )->Utils.catchLogAndIgnore()
}

let saveGameConfirmation = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
  confirmation: ConfirmationCodec.t,
) => {
  updateGameKey(
    dbConnection,
    gameId,
    subject,
    confirmation->ConfirmationCodec.t_encode,
  )->Utils.catchLogAndIgnore()
}

let saveGameConfirmations = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  confirmWitches: ConfirmationCodec.t,
  confirmConstable: ConfirmationCodec.t,
): unit => {
  Promise.all([
    updateGameKey(
      dbConnection,
      gameId,
      ConfirmWitchesSubject,
      confirmWitches->ConfirmationCodec.t_encode,
    ),
    updateGameKey(
      dbConnection,
      gameId,
      ConfirmConstableSubject,
      confirmConstable->ConfirmationCodec.t_encode,
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
  let phase = getPhase(page, scenarioStep)
  updateGameKey(
    dbConnection,
    gameId,
    MasterPhaseSubject,
    phase->PhaseCodec.t_encode,
  )->Utils.catchLogAndIgnore()
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
