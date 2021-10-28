/** ****************************************************************************
 * FirebaseClient
 */

open Types
open Types.FbDb

let gamesKeyPrefix = "/games/"

/** **********************************************************************
 * Functions
 */

let getDbPage = (
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
        | (DaytimeConfess,         _) => #DaytimeWaiting
        | (DaytimeReveal,          _) => #DaytimeWaiting
        | (DaytimeRevealNoConfess, _) => #DaytimeWaiting
        | (Close,                  _) => #DaytimeWaiting
        | (_,          ChooseWitches) => #NightChooseWitches
        | (_,         ConfirmWitches) => #NightConfirmWitches
        | (_,        ChooseConstable) => #NightChooseConstable
        | (_,       ConfirmConstable) => #NightConfirmConstable
        | (_,                      _) => #NightWaiting
    }
}

let transformToDbRecord = (
    gameState: gameState,
    currentPage: page,
    turnState: turnState,
    scenarioStep: scenarioStep,
): dbRecord => {
    masterGameId: gameState.gameId,
    masterPhase: getDbPage(currentPage, scenarioStep),
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

let deleteGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    FirebaseAdapter.deleteGame(dbConnection, gameId)
}

let ifMasterAndConnectedThenSaveGameState = (
    dbConnectionStatus: dbConnectionStatus,
    gameState: gameState,
    page: page,
    turnState: turnState,
    maybeScenarioStep: option<scenarioStep>,
) => {
    Utils.ifMaster(
        gameState.gameType,
        () => {
            Utils.ifConnected(
                dbConnectionStatus,
                (dbConnection) => updateGame(dbConnection, gameState, page, turnState, maybeScenarioStep)
                    ->Promise.catch((error) => {
                        // don't immediately disconnect
                        // setDbConnectionStatus(_prev => NotConnected)
                        error
                            ->Utils.getExceptionMessage
                            ->Utils.logError
                        Promise.resolve()
                    })
                    ->ignore
            )
        }
    )
}

