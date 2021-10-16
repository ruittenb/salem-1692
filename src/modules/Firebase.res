/** ****************************************************************************
 * Firebase
 */

open Types.FbDb
open Utils

@module("firebase/app") external initializeApp: (config) => app = "initializeApp"
@module("firebase/database") external getDatabase: (app => database) = "getDatabase"
@module("firebase/database") external getRef: (database, string) => reference = "ref"
@module("firebase/database") external onValue: (reference, (snapshot) => unit) => unit = "onValue"
@module("firebase/database") external off: (reference) => unit = "off"
@module("firebase/database") external set: (reference, data) => unit = "set"
@send external getValue: (snapshot) => data = "val"

/**
 * Functions
 */

let connect = (): dbConnection => {
    // TODO try/catch
    let app = initializeApp(Constants.firebaseConfig)
    let db = getDatabase(app)
    { app, db }
}

let createGame = (
//    dbConnection: dbConnection,
//    gameId: GameTypeCodec.gameId
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
        () => getRef(dbConnection.db, "games/" ++ gameId)
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
        () => getRef(dbConnection.db, "games/" ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        off(myGameRef)
        Js.log("Left game " ++ gameId)
    })
}

