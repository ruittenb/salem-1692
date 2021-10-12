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

let connect = (
    gameId: GameTypeCodec.gameId
): unit => {
    let firebaseApp = initializeApp(Constants.firebaseConfig)
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
