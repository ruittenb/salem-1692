
/** ****************************************************************************
 * GameStateContext
 */

open Types

let defaultSetter: gameStateSetter = (_: gameState => gameState) => ()
let defaultValue: gameState = {
    gameType: StandAlone,
    gameId: GameId.getGameId(),
    language: #en_US,
    players: [],
    seating: #TwoAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: [],
}
let context = React.createContext(
    (defaultValue, defaultSetter)
)

module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

