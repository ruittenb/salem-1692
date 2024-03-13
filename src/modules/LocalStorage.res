/* *****************************************************************************
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

let gameStateKey = Constants.localStoragePrefix ++ Constants.localStorageGameStateKey

let loadGameState = (): option<gameState> => {
  Dom.Storage2.localStorage
  ->Dom.Storage2.getItem(gameStateKey) // this yields an option<string>
  ->Belt.Option.flatMap(jsonString => safeExec(() => jsonString->Js.Json.parseExn)) // this yields an option<Js.Json.t>
  ->Belt.Option.flatMap(str =>
    str->gameState_decode->Belt.Result.mapWithDefault(None, Js.Option.some)
  ) // this mapper yields a Result<gameState, Decco.decodeError>
}

let saveGameState = (gameState: gameState): unit => {
  gameState
  ->gameState_encode
  ->Js.Json.stringifyAny
  ->Belt.Option.forEach(jsonGameState => setItem(gameStateKey, jsonGameState))
}
