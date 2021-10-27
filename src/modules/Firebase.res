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

/**
 * Functions
 */

let transformToDbRecord = (gameState: gameState): dbRecord => {
    masterGameId: gameState.gameId,
    masterPhase: #DaytimeParked,
    masterPlayers: gameState.players,
    masterSeating: SeatingCodec.seatingToJs(gameState.seating),
    slaveChoiceWitches: "",
    slaveChoiceConstable: "",
    slaveConfirmWitches: Undecided,
    slaveConfirmConstable: Undecided,
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
    action: string, // "created" or "updated"
): Promise.t<unit> => {
    let dbRecord = transformToDbRecord(gameState)
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
    upsertGame(dbConnection, gameState, "Created")
}

let updateGame = (
    dbConnection: dbConnection,
    gameState: gameState
): Promise.t<unit> => {
    upsertGame(dbConnection, gameState, "Updated")
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

