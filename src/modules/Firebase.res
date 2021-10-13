/** ****************************************************************************
 * Firebase
 */

// @@warning("-33") // Unused 'open Types'

open Types.Firebase
open Utils

@module("firebase/app") external initializeApp: (config) => app = "initializeApp"
@module("firebase/database") external getDatabase: (app => database) = "getDatabase"
@module("firebase/database") external getRef: (database, string) => reference = "ref"
@module("firebase/database") external onValue: (reference, (snapshot) => unit) => unit = "onValue"
@module("firebase/database") external set: (reference, data) => unit = "set"
@send external getValue: (snapshot) => data = "val"

/**
 * Functions
 */

let connect = (): connection => {
    // TODO try/catch
    let app = initializeApp(Constants.firebaseConfig)
    let db = getDatabase(app)
    { app, db }
}

let createGame = (
    connection: connection,
    gameId: GameTypeCodec.gameId
): unit => {
    () // TODO
}

let destroyGame = (
//    connection: connection,
//    gameId: GameTypeCodec.gameId
): unit => {
    () // TODO
}

let joinGame = (
    connection: connection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(connection.db, "games/" ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        onValue(myGameRef, (snapshot: snapshot) => {
            let _data = getValue(snapshot)
        })
    })
}

