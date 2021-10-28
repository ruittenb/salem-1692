/** ****************************************************************************
 * Firebase
 */

open Types
open Types.FbDb
open Utils

@module("firebase/app") external initializeApp: (config) => app = "initializeApp"
@module("firebase/database") external getDatabase: (app => database) = "getDatabase"
@module("firebase/database") external getRef: (database, string) => reference = "ref"
@module("firebase/database") external onConnect: (database, () => unit) => unit = "onConnect"
@module("firebase/database") external goOffline: (database) => unit = "goOffline"
@module("firebase/database") external onValue: (reference, (snapshot) => unit) => unit = "onValue"
@module("firebase/database") external off: (reference) => unit = "off"
@module("firebase/database") external set: (reference, 'data) => Promise.t<unit> = "set"
@module("firebase/database") external remove: (reference) => unit = "remove"
@send external getValue: (snapshot) => 'data = "val"

let connectionInfoKey = "/.info/connected"
let gamesKeyPrefix = "/games/"

/** **********************************************************************
 * Functions
 */

let getDbPage = (
    page: page,
    step: scenarioStep,
): phase => {
    switch (page, step) {
        | (Title,                  _) => #DaytimeParked
        | (Setup,                  _) => #DaytimeParked
        | (SetupLanguage,          _) => #DaytimeParked
        | (SetupMusic,             _) => #DaytimeParked
        | (SetupPlayers,           _) => #DaytimeParked
        | (SetupPlayersForGame,    _) => #DaytimeParked
        | (SetupMaster,            _) => #DaytimeParked
        | (SetupSlave,             _) => #DaytimeParked
        | (Credits,                _) => #DaytimeParked
        | (Daytime,                _) => #DaytimeParked
        | (DaytimeConfess,         _) => #DaytimeParked
        | (DaytimeReveal,          _) => #DaytimeParked
        | (DaytimeRevealNoConfess, _) => #DaytimeParked
        | (Close,                  _) => #DaytimeParked
        | (_,          ChooseWitches) => #NightChooseWitches
        | (_,         ConfirmWitches) => #NightConfirmWitches
        | (_,        ChooseConstable) => #NightChooseConstable
        | (_,       ConfirmConstable) => #NightConfirmConstable
        | (_,                      _) => #NightParked
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
 * connect/disconnect
 */

let connect = (): Promise.t<dbConnection> => {
    Promise.make((resolve, reject) => {
        try {
            let app = initializeApp(Constants.firebaseConfig)
            let db = getDatabase(app)
            let connectionInfoRef = getRef(db, connectionInfoKey);
            onValue(connectionInfoRef, (snapshot) => {
                let connected: bool = getValue(snapshot)
                if (connected) {
                    logDebug("Connected")
                    resolve(. { app, db })
                }
            })
        } catch {
            | error => reject(. error)
        }
    })
}

let disconnect = (
    dbConnection: dbConnection
): unit => {
    let connectionInfoRef = getRef(dbConnection.db, connectionInfoKey);
    off(connectionInfoRef)
    // We could go offline here, but then reconnecting would require a
    // different method than when connecting for the first time.
    //goOffline(dbConnection.db)
    logDebug("Disconnected")
}

/** **********************************************************************
 * create/update/delete (Master)
 */

let upsertGame = (
    dbConnection: dbConnection,
    gameState: gameState,
    currentPage: page,
    turnState: turnState,
    maybeScenarioStep: option<scenarioStep>,
    action: string, // "created" or "updated"
): Promise.t<unit> => {
    let dbRecord = transformToDbRecord(
        gameState,
        currentPage,
        turnState,
        maybeScenarioStep->Belt.Option.getWithDefault(Pause(0.))
    )
    Promise.make((resolve, reject) => {
        try {
            let myGameRef = getRef(dbConnection.db, gamesKeyPrefix ++ gameState.gameId)
            set(myGameRef, dbRecord)
                ->Promise.then(() => {
                    logDebug(action ++ " game " ++ gameState.gameId)
                    resolve(. ignore())
                    Promise.resolve()
                })
                ->Promise.catch(error => {
                    error->getExceptionMessage->logError
                    reject(. error)
                    Promise.reject(error)
                })
                ->ignore
        } catch {
            | error => reject(. error)
        }
    })
}

let createGame = (
    dbConnection: dbConnection,
    gameState: gameState
): Promise.t<unit> => {
    let emptyTurnState: turnState = {
        nrWitches: One,
        choiceWitches: None,
        choiceConstable: None,
    }
    upsertGame(dbConnection, gameState, Title, emptyTurnState, None, "Created")
}

let updateGame = (
    dbConnection: dbConnection,
    gameState: gameState,
    currentPage: page,
    turnState: turnState,
    maybeScenarioStep: option<scenarioStep>,
): Promise.t<unit> => {
    upsertGame(dbConnection, gameState, currentPage, turnState, maybeScenarioStep, "Updated")
}

let deleteGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        remove(myGameRef)
        logDebug("Deleted game " ++ gameId)
    })
}

/** **********************************************************************
 * join/leave (Slave)
 */

let joinGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        logDebug("Joined game " ++ gameId)
        onValue(myGameRef, (snapshot: snapshot) => {
            logDebug("Data received")
            let _data = getValue(snapshot)
        })
    })
}

let leaveGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        off(myGameRef)
        logDebug("Left game " ++ gameId)
    })
}

