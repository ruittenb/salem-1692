/* *****************************************************************************
 * LocalStorage
 */

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
  ->Option.flatMap(jsonString => safeExec(() => jsonString->JSON.parseExn)) // this yields an option<JSON.t>
  ->Option.flatMap(str => str->gameState_decode->Result.mapOr(None, x => Some(x)))
}

let saveGameState = (gameState: gameState): unit => {
  gameState
  ->gameState_encode
  ->JSON.stringifyAny
  ->Option.forEach(jsonGameState => setItem(gameStateKey, jsonGameState))
}
