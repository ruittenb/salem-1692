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
@module("firebase/database") external onValue: (reference, (snapshot) => unit) => unit = "onValue"
@module("firebase/database") external off: (reference) => unit = "off"
@module("firebase/database") external set: (reference, data) => unit = "set"
@send external getValue: (snapshot) => 'data = "val"

let connectionInfoKey = "/.info/connected"
let gamesKeyPrefix = "/games/"

/**
 * Functions
 */

let connect = (): Promise.t<dbConnection> => {
    Promise.make((resolve, _reject) => {
        let app = initializeApp(Constants.firebaseConfig)
        let db = getDatabase(app)
        let connectionInfoRef = getRef(db, connectionInfoKey);
        onValue(connectionInfoRef, (snapshot) => {
            let connected: bool = getValue(snapshot)
            if (connected) {
                Js.log("Connected")
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
    Js.log("Disconnected")
}

let createGame = (
    dbConnection: dbConnection,
    gameState: gameState
): unit => {
    () // TODO
}

let destroyGame = (
//    dbConnection: dbConnection,
//    gameId: GameTypeCodec.gameId
): unit => {
    () // TODO
}

let joinGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        Js.log("Joined game " ++ gameId)
        onValue(myGameRef, (snapshot: snapshot) => {
            Js.log("Data received")
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
        Js.log("Left game " ++ gameId)
    })
}

