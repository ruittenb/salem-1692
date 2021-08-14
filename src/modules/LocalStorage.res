
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
