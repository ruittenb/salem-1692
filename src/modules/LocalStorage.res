
/** ****************************************************************************
 * LocalStorage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Utils

let setItem = (key: string, value: string): unit => {
    Dom.Storage2.localStorage->Dom.Storage2.setItem(key, value)
}

let getItem = (key: string): option<string> => {
    Dom.Storage2.localStorage->Dom.Storage2.getItem(key)
}

let getStringArray = (key: string): option<array<string>> => {
    Dom.Storage2.localStorage
        ->Dom.Storage2.getItem(key)                      // this yields an option<string>
        ->Belt.Option.flatMap(
            jsonString => safeExec(
                () => jsonString->Js.Json.parseExn
            )
        )                                                // this yields an option<Js.Json.t>
        ->Belt.Option.flatMap(Js.Json.decodeArray)       // this yields an option<array<Js.Json.t>>
        ->Belt.Option.map(
            jsonArray => jsonArray
                ->Js.Array2.map(Js.Json.decodeString)    // this yields an array<option<string>>
                ->Belt.Array.keepMap(identity)           // this yields an array<string>
        )                                                // this yields an option<array<string>>
}

let encoded: option<string> = {
    players: [ "Xornor", "Gnorf", "Bloop" ],
    seating: #OneAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: [],
}
    ->gameState_encode
    ->Js.Json.stringifyAny
Js.log2("initial game state:", encoded) // TODO

let decoded: option<gameState> = encoded
    ->Belt.Option.flatMap(
        str => str
            ->Js.Json.parseExn
            ->gameState_decode
            ->Belt.Result.mapWithDefault(None, Js.Option.some)
    )
Js.log2("encoded/decoded gameState:", decoded) // TODO



