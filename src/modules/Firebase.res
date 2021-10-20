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
@module("firebase/database") external set: (reference, 'data) => unit = "set"
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
}

/** **********************************************************************
 * connect/disconnect
 */

let connect = (): Promise.t<dbConnection> => {
    Promise.make((resolve, _reject) => {
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
    })
}

let disconnect = (
    dbConnection: dbConnection
): unit => {
    let connectionInfoRef = getRef(dbConnection.db, connectionInfoKey);
    off(connectionInfoRef)
    // We could go offline here, but then reconnecting would require a
    // different method than when connecting the first time.
    //goOffline(dbConnection.db)
    logDebug("Disconnected")
}

/** **********************************************************************
 * create/destroy (Master)
 */

let createGame = (
    dbConnection: dbConnection,
    gameState: gameState
): unit => {
    let dbRecord = transformToDbRecord(gameState)
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameState.gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        set(myGameRef, dbRecord)
        logDebug("Created game " ++ gameState.gameId)
    })
}

let destroyGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        remove(myGameRef)
        logDebug("Destroyed game " ++ gameId)
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

