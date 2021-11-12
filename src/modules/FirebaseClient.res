/** ****************************************************************************
 * FirebaseClient
 */

open Types
open Types.FbDb

let gamesKeyPrefix = "/games/"

/** **********************************************************************
 * Functions
 */

let getPhase = (
    page: page,
    step: scenarioStep,
): phase => {
    switch (page, step) {
        | (Title,                  _) => #DaytimeWaiting
        | (Setup,                  _) => #DaytimeWaiting
        | (SetupLanguage,          _) => #DaytimeWaiting
        | (SetupMusic,             _) => #DaytimeWaiting
        | (SetupPlayers,           _) => #DaytimeWaiting
        | (SetupPlayersForGame,    _) => #DaytimeWaiting
        | (SetupMaster,            _) => #DaytimeWaiting
        | (SetupSlave,             _) => #DaytimeWaiting
        | (Credits,                _) => #DaytimeWaiting
        | (Daytime,                _) => #DaytimeWaiting
        | (DaytimeWaiting,         _) => #DaytimeWaiting
        | (DaytimeConfess,         _) => #DaytimeWaiting
        | (DaytimeReveal,          _) => #DaytimeWaiting
        | (DaytimeRevealNoConfess, _) => #DaytimeWaiting
        | (Close,                  _) => #DaytimeWaiting
        | (_,          ChooseWitches) => #NightChoiceWitches
        | (_,         ConfirmWitches) => #NightConfirmWitches
        | (_,        ChooseConstable) => #NightChoiceConstable
        | (_,       ConfirmConstable) => #NightConfirmConstable
        | (_,                      _) => #NightWaiting
    }
}

let getPage = (
    phase: phase
): page => {
    switch phase {
        | #DaytimeWaiting        => DaytimeWaiting
        | #NightWaiting          => NightWaiting
        | #NightChoiceWitches    => NightChoiceWitches
        | #NightConfirmWitches   => NightConfirmWitches
        | #NightChoiceConstable  => NightChoiceConstable
        | #NightConfirmConstable => NightConfirmConstable
    }
}

let transformToDbRecord = (
    gameState: gameState,
    currentPage: page,
    turnState: turnState,
    scenarioStep: scenarioStep,
): dbRecord => {
    masterGameId: gameState.gameId,
    masterPhase: getPhase(currentPage, scenarioStep),
    masterPlayers: gameState.players,
    masterSeating: SeatingCodec.seatingToJs(gameState.seating),
    slaveChoiceWitches: turnState.choiceWitches->Belt.Option.getWithDefault(""),
    slaveChoiceConstable: turnState.choiceConstable->Belt.Option.getWithDefault(""),
    slaveConfirmWitches: #Undecided,
    slaveConfirmConstable: #Undecided,
    updatedAt: Js.Date.make()->Js.Date.toISOString
}

/** **********************************************************************
 * connect/disconnect: forward to adapter
 */

let connect = (): Promise.t<dbConnection> => {
    FirebaseAdapter.connect()
}

let disconnect = (
    dbConnection: dbConnection
): unit => {
    FirebaseAdapter.disconnect(dbConnection)
}

/** **********************************************************************
 * join/leave (Slave): forward to adapter
 */

let joinGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    FirebaseAdapter.joinGame(dbConnection, gameId)
}

let leaveGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    FirebaseAdapter.leaveGame(dbConnection, gameId)
}

/** **********************************************************************
 * create/update/delete (Master)
 */

let createGame = (
    dbConnection: dbConnection,
    gameState: gameState,
): Promise.t<unit> => {
    let emptyTurnState: turnState = {
        nrWitches: One,
        choiceWitches: None,
        choiceConstable: None,
    }
    let dbRecord = transformToDbRecord(
        gameState,
        Title,
        emptyTurnState,
        Pause(0.),
    )
    FirebaseAdapter.writeGame(dbConnection, dbRecord, "Created")
}

let updateGame = (
    dbConnection: dbConnection,
    gameState: gameState,
    currentPage: page,
    turnState: turnState,
    maybeScenarioStep: option<scenarioStep>,
): Promise.t<unit> => {
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
    key: string,
    value: string,
): Promise.t<unit> => {
    FirebaseAdapter.writeGameKey(dbConnection, gameId, key, value)
}

let deleteGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    FirebaseAdapter.deleteGame(dbConnection, gameId)
}

let saveGameState = (
    dbConnection: dbConnection,
    gameState: gameState,
    page: page,
    turnState: turnState,
    maybeScenarioStep: option<scenarioStep>,
): unit => {
    updateGame(dbConnection, gameState, page, turnState, maybeScenarioStep)
        ->Utils.catchLogAndIgnore()
}

let saveGameChoices = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    choiceWitches: player,
    choiceConstable: player,
): unit => {
    Promise.all([
        updateGameKey(dbConnection, gameId, "slaveChoiceWitches", choiceWitches),
        updateGameKey(dbConnection, gameId, "slaveChoiceConstable", choiceConstable)
    ])
        ->Utils.catchLogAndIgnore([])
}

let saveGameConfirmation = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    subject: dbObservable,
    confirmation: decision,
) => {
    updateGameKey(dbConnection, gameId, FirebaseAdapter.subjectKey(subject), confirmation->decisionToJs)
        ->Utils.catchLogAndIgnore()
}

let saveGameConfirmations = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    confirmWitches: decision,
    confirmConstable: decision,
): unit => {
    Promise.all([
        updateGameKey(dbConnection, gameId, "slaveConfirmWitches", confirmWitches->decisionToJs),
        updateGameKey(dbConnection, gameId, "slaveConfirmConstable", confirmConstable->decisionToJs)
    ])
        ->Utils.catchLogAndIgnore([])
}

let saveGamePhase = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    page: page,
    maybeScenarioStep: option<scenarioStep>,
): unit => {
    let scenarioStep = maybeScenarioStep->Belt.Option.getWithDefault(Pause(0.))
    let phase = getPhase(page, scenarioStep)->phaseToJs
    updateGameKey(dbConnection, gameId, "masterPhase", phase)
        ->Utils.catchLogAndIgnore()
}

/** **********************************************************************
 * listen (Master)
 */

let listen = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    subject: dbObservable,
    callback: (string) => unit
): unit => {
    FirebaseAdapter.listen(
        dbConnection,
        gameId,
        FirebaseAdapter.subjectKey(subject),
        callback
    )
}

let stopListening = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    subject: dbObservable,
): unit => {
    FirebaseAdapter.stopListening(
        dbConnection,
        gameId,
        FirebaseAdapter.subjectKey(subject)
    )
}
