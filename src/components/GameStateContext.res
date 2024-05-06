/* *****************************************************************************
 * GameStateContext
 */

open Types

let defaultSetter: gameStateSetter = (_: gameState => gameState) => ()

// Note: this is not the initial value: it is defined in Constants
let defaultValue: gameState = {
  gameType: StandAlone,
  language: #en_US,
  players: [],
  seating: #TwoAtTop,
  hasGhostPlayers: false,
  doPlayEffects: true,
  doPlaySpeech: true,
  doPlayMusic: true,
  doKeepActive: true,
  backgroundMusic: [],
}
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
