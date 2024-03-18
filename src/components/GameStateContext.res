/* *****************************************************************************
 * GameStateContext
 */

open Types

let defaultSetter: gameStateSetter = (_: gameState => gameState) => ()
let defaultValue: gameState = {
  gameType: StandAlone,
  language: #en_US,
  players: [],
  seating: #TwoAtTop,
  hasGhostPlayers: false,
  doPlayEffects: true,
  doPlaySpeech: true,
  doPlayMusic: true,
  backgroundMusic: [],
}
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
