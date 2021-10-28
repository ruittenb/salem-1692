/** ****************************************************************************
 * FirebaseAdapter
 */

@@warning("-33") // Unused 'open Types'

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
 * connect/disconnect
 */

let connect = (): Promise.t<dbConnection> => {
    Promise.make((resolve, reject) => {
        try {
            let app = initializeApp(Constants.firebaseConfig)
            let db = getDatabase(app)
            let connectionInfoRef = getRef(db, connectionInfoKey);
            // We usually receive more than one snapshot, therefore don't use 'once'
            onValue(connectionInfoRef, (snapshot) => {
                let connected: bool = getValue(snapshot)
                if (connected) {
                    Utils.logDebug("Connected")
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
    Utils.logDebug("Disconnected")
}

/** **********************************************************************
 * write/delete (Master)
 */

let writeGame = (
    dbConnection: dbConnection,
    dbRecord: dbRecord,
    action: string, // "created" or "updated"
): Promise.t<unit> => {
    Promise.make((resolve, reject) => {
        try {
            let gameId = dbRecord.masterGameId
            let myGameRef = getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
            set(myGameRef, dbRecord)
                ->Promise.then(() => {
                    Utils.logDebug(action ++ " game " ++ gameId)
                    resolve(. ignore()) // workaround to pass a unit argument
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

let deleteGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gamesKeyPrefix ++ gameId)
    )
    ->Belt.Option.forEach(myGameRef => {
        remove(myGameRef)
        Utils.logDebug("Deleted game " ++ gameId)
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
        Utils.logDebug("Joined game " ++ gameId)
        onValue(myGameRef, (snapshot: snapshot) => {
            Utils.logDebug("Data received")
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
        Utils.logDebug("Left game " ++ gameId)
    })
}

