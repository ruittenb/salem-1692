/** ****************************************************************************
 * Firebase
 */

// @@warning("-33") // Unused 'open Types'

open Types
open Utils

@module("firebase/app") external initializeApp: (fbConfig) => fbApp = "initializeApp"
@module("firebase/database") external getDatabase: (fbApp => fbDatabase) = "getDatabase"
@module("firebase/database") external getRef: (fbDatabase, string) => fbRef = "ref"
@module("firebase/database") external onValue: (fbRef, (fbSnapshot) => unit) => unit = "onValue"
@send external getValue: (fbSnapshot) => fbData = "val"

/**
 * Functions
 */

let connect = (): fbConnection => {
    // TODO try/catch
    let app = initializeApp(Constants.firebaseConfig)
    let db = getDatabase(app)
    { app, db }
}

let createGame = (
): unit => {
    () // TODO
}

let destroyGame = (
): unit => {
    () // TODO
}

let joinGame = (
    connection: fbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(connection.db, "games/" ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        onValue(myGameRef, (snapshot: fbSnapshot) => {
            let _data = getValue(snapshot)
        })
    })
}
