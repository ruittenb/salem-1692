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

let p = "[FirebaseAdapter] "

let connectionInfoKey = "/.info/connected"

let gameKey = (id: GameTypeCodec.gameId): string => {
    "/games/" ++ id
}

let subjectKey = (subject) => switch subject {
    | MasterPhaseSubject       => "masterPhase"
    | MasterPlayersSubject     => "masterPlayers"
    | MasterSeatingSubject     => "masterSeating"
    | ChooseWitchesSubject     => "slaveChoiceWitches"
    | ChooseConstableSubject   => "slaveChoiceConstable"
    | ConfirmWitchesSubject    => "slaveConfirmWitches"
    | ConfirmConstableSubject  => "slaveConfirmConstable"
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
            // We will immediately receive a snapshot upon attaching the listener;
            // and then upon every change.
            onValue(connectionInfoRef, (snapshot) => {
                let connected: bool = getValue(snapshot)
                if (connected) {
                    Utils.logDebug(p ++ "Connected")
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
    Utils.logDebug(p ++ "Disconnected")
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
            let myGameRef = getRef(dbConnection.db, gameKey(gameId))
            set(myGameRef, dbRecord)
                ->Promise.then(() => {
                    Utils.logDebug(p ++ action ++ " game " ++ gameId)
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

let writeGameKey = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    key: string,
    value: string,
): Promise.t<unit> => {
    Promise.make((resolve, reject) => {
        try {
            let myGameRef = getRef(dbConnection.db, gameKey(gameId) ++ "/" ++ key)
            set(myGameRef, value)
                ->Promise.then(() => {
                    Utils.logDebug(p ++ "Updated game key " ++ key ++ " with value " ++ value)
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
        () => getRef(dbConnection.db, gameKey(gameId))
    )
    ->Belt.Option.forEach(myGameRef => {
        remove(myGameRef)
        Utils.logDebug(p ++ "Deleted game " ++ gameId)
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
        () => getRef(dbConnection.db, gameKey(gameId))
    )
    ->Belt.Option.forEach(myGameRef => {
        Utils.logDebug(p ++ "Joined game " ++ gameId)
        onValue(myGameRef, (snapshot: snapshot) => {
            Utils.logDebug(p ++ "Received data")
            let _data = getValue(snapshot)
        })
    })
}

let leaveGame = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId
): unit => {
    safeExec(
        () => getRef(dbConnection.db, gameKey(gameId))
    )
    ->Belt.Option.forEach(myGameRef => {
        off(myGameRef)
        Utils.logDebug(p ++ "Left game " ++ gameId)
    })
}

/** **********************************************************************
 * listen (Master)
 */

let listen = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    subjectKey: string,
    callback: (string) => unit
): unit => {
    let observableKey = gameKey(gameId) ++ "/" ++ subjectKey
    safeExec(
        // TODO What to do if this fails?
        () => getRef(dbConnection.db, observableKey)
    )
    ->Belt.Option.forEach(observableRef => {
        Utils.logDebug(p ++ "Listening on " ++ observableKey)
        onValue(observableRef, (snapshot) => {
            // We are going to get a snapshot immediately upon installing the listener.
            // Since the observed key is always cleared in NightScenarioPage, we don't
            // need to worry about this and we can let the observer deal with it.
            let result: string = getValue(snapshot)
            Utils.logDebug(p ++ "Received data from " ++ observableKey ++ ": '" ++ result ++ "'")
            callback(result)
        })
    })
}

let stopListening = (
    dbConnection: dbConnection,
    gameId: GameTypeCodec.gameId,
    subjectKey: string,
): unit => {
    let observableKey = gameKey(gameId) ++ "/" ++ subjectKey
    safeExec(
        // TODO What to do if this fails?
        () => getRef(dbConnection.db, observableKey)
    )
    ->Belt.Option.forEach(observableRef => {
        Utils.logDebug(p ++ "Stopping listening on " ++ observableKey)
        off(observableRef)
    })
}

