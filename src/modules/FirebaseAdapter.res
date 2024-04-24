/* *****************************************************************************
 * FirebaseAdapter
 */

@@warning("-33") // Unused 'open Types'

open Types
open Utils

@module("firebase/app") external initializeApp: dbConfig => dbApp = "initializeApp"
@module("firebase/database") external getDatabase: dbApp => dbDatabase = "getDatabase"
@module("firebase/database") external getRef: (dbDatabase, string) => dbReference = "ref"
@module("firebase/database") external onConnect: (dbDatabase, unit => unit) => unit = "onConnect"
@module("firebase/database") external goOffline: dbDatabase => unit = "goOffline"
@module("firebase/database") external onValue: (dbReference, dbSnapshot => unit) => unit = "onValue"
@module("firebase/database") external off: dbReference => unit = "off"
@module("firebase/database") external set: (dbReference, 'data) => promise<unit> = "set"
@module("firebase/database") external remove: dbReference => unit = "remove"
@module("firebase/analytics") external getAnalytics: dbApp => dbAnalytics = "getAnalytics"
@send external getValue: dbSnapshot => 'data = "val"

let p = "[FirebaseAdapter] "

let connectionInfoKey = "/.info/connected"

let gameKey = (id: GameTypeCodec.gameId): string => {
  "/games/" ++ id
}

let subjectKey = subject =>
  switch subject {
  | GameSubject => ""
  | MasterPhaseSubject => "masterPhase"
  | MasterPlayersSubject => "masterPlayers"
  | MasterSeatingSubject => "masterSeating"
  | MasterNumberWitchesSubject => "masterNumberWitches"
  | MasterNightTypeSubject => "masterNightType"
  | MasterHasGhostPlayersSubject => "masterHasGhostPlayers"
  | ChoiceWitchesSubject => "slaveChoiceWitches"
  | ChoiceConstableSubject => "slaveChoiceConstable"
  | ConfirmWitchesSubject => "slaveConfirmWitches"
  | ConfirmConstableSubject => "slaveConfirmConstable"
  }

/* ************************************************************************
 * connect/disconnect
 */

let connect = (): promise<dbConnection> => {
  Promise.make((resolve, reject) => {
    try {
      let app = initializeApp(Constants.firebaseConfig)
      let db = getDatabase(app)
      let _analytics = getAnalytics(app)
      let connectionInfoRef = getRef(db, connectionInfoKey)
      // We will immediately receive a snapshot upon attaching the listener;
      // and then upon every change.
      onValue(connectionInfoRef, snapshot => {
        let connected: bool = getValue(snapshot)
        if connected {
          logDebug(p ++ "Connected")
          resolve(. {app, db})
        }
      })
    } catch {
    | error => reject(. error)
    }
  })
}

let disconnect = (dbConnection: dbConnection): unit => {
  let connectionInfoRef = getRef(dbConnection.db, connectionInfoKey)
  off(connectionInfoRef)
  // We could go offline here, but then reconnecting would require a
  // different method than when connecting for the first time.
  //goOffline(dbConnection.db)
  logDebug(p ++ "Disconnected")
}

/* ************************************************************************
 * write/delete (Master)
 */

let writeGame = (
  dbConnection: dbConnection,
  dbRecord: dbRecord,
  action: string,
): // "created" or "updated"
promise<unit> => {
  Promise.make((resolve, reject) => {
    try {
      let gameId = dbRecord.masterGameId
      let myGameRef = getRef(dbConnection.db, gameKey(gameId))
      // Utils.logDebug(p ++ "Saving: " ++ dbRecord->dbRecord_encode->Js.Json.stringify)
      set(myGameRef, dbRecord->dbRecord_encode)
      ->Promise.then(() => {
        logDebug(p ++ action ++ " game " ++ gameId)
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
  subject: dbObservable,
  value: Js.Json.t,
): promise<unit> => {
  let key = subjectKey(subject)
  Promise.make((resolve, reject) => {
    try {
      let myGameRef = getRef(dbConnection.db, gameKey(gameId) ++ "/" ++ key)
      set(myGameRef, value)
      ->Promise.then(() => {
        logDebug(p ++ "Updated game key " ++ key ++ " with value " ++ value->Js.Json.stringify)
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

let deleteGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): unit => {
  safeExec(() => getRef(dbConnection.db, gameKey(gameId)))->Belt.Option.forEach(myGameRef => {
    remove(myGameRef)
    logDebug(p ++ "Deleted game " ++ gameId)
  })
}

/* ************************************************************************
 * join/leave (Slave)
 */

let joinGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): bool => {
  let maybeGameRef = safeExec(() => getRef(dbConnection.db, gameKey(gameId)))
  switch maybeGameRef {
  | Some(myGameRef) => {
      logDebug(p ++ "Joined game " ++ gameId)
      onValue(myGameRef, (snapshot: dbSnapshot) => {
        logDebug(p ++ "Received data")
        let _data = getValue(snapshot) // TODO
      })
      true
    }
  | None => {
      logDebug(p ++ "Unable to join game " ++ gameId)
      false
    }
  }
}

let leaveGame = (dbConnection: dbConnection, gameId: GameTypeCodec.gameId): unit => {
  safeExec(() => getRef(dbConnection.db, gameKey(gameId)))->Belt.Option.forEach(myGameRef => {
    off(myGameRef)
    logDebug(p ++ "Left game " ++ gameId)
  })
}

/* ************************************************************************
 * listen (Master)
 */

let listen = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
  callback: option<string> => unit,
): unit => {
  let observableKey = gameKey(gameId) ++ "/" ++ subjectKey(subject)
  let maybeGameRef = safeExec(() => getRef(dbConnection.db, observableKey))
  switch maybeGameRef {
  | Some(observableRef) => {
      logDebug(p ++ "Listening on " ++ observableKey)
      onValue(observableRef, snapshot => {
        // We will receive a snapshot immediately upon installing the listener.
        // NightScenarioPage takes care of this, so we can ignore it here.
        let result: Js.Nullable.t<string> = getValue(snapshot)
        if Constants.debug {
          Js.log2(p ++ "Received data from " ++ observableKey ++ ":", result)
        }
        callback(result->Js.Nullable.toOption)
      })
    }
  | None => {
      logDebug(p ++ "Unable to listen on " ++ observableKey)
      callback(None)
    }
  }
}

let stopListening = (
  dbConnection: dbConnection,
  gameId: GameTypeCodec.gameId,
  subject: dbObservable,
): unit => {
  let observableKey = gameKey(gameId) ++ "/" ++ subjectKey(subject)
  safeExec(// TODO What to do if this fails?
  () => getRef(dbConnection.db, observableKey))->Belt.Option.forEach(observableRef => {
    logDebug(p ++ "Stopping listening on " ++ observableKey)
    off(observableRef)
  })
}
