/** ****************************************************************************
 * Firebase
 */

@@warning("-33") // Unused 'open Types'

open Types
open Utils

@module("firebase/app") external initializeApp: (firebaseConfig) => 'fbApp = "initializeApp"
@module("firebase/database") external getDatabase: ('fbApp => 'fbDatabase) = "getDatabase"
@module("firebase/database") external getRef: ('fbDatabase, string) => 'fbRef = "ref"
@module("firebase/database") external onValue: ('fbRef, ('fbSnapshot) => unit) => unit = "onValue"
@send external getValue: ('fbSnapshot) => 'fbData = "val"

// Your web app's Firebase configuration
let firebaseConfig: firebaseConfig = {
    apiKey            : "AIzaSyD_SDDuyHYXcj_xiw8V_BXmWb_X9TUWpK8",
    authDomain        : "salem-1692-moderator.firebaseapp.com",
    databaseURL       : "https://salem-1692-moderator-default-rtdb.europe-west1.firebasedatabase.app",
    projectId         : "salem-1692-moderator",
    storageBucket     : "salem-1692-moderator.appspot.com",
    messagingSenderId : "910714101001",
    appId             : "1:910714101001:web:1a9d4882f11f07376807d8",
}

let connect = (
    gameId: GameTypeCodec.gameId
): unit => {
    let firebaseApp = initializeApp(firebaseConfig)
    let firebaseDb = getDatabase(firebaseApp)
    safeExec(
        () => getRef(firebaseDb, "games/" ++ gameId)
    )
    ->Belt.Option.forEach((myGameRef) => {
        onValue(myGameRef, (snapshot: 'fbSnapshot) => {
            let _data = getValue(snapshot)
        })
    })
}

/* let openGame = ( */
/*     gameId: GameTypeCodec.gameId */
/* ): unit => { */
/*     () */
/* } */
