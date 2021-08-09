
/** ****************************************************************************
 * GameStateContext
 */

open Types

let defaultSetter: gameStateSetter = (_: gameState => gameState) => ()
let defaultState: gameState = {
    players: [],
    seatingLayout: TwoAtHead,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: [],
}
let context = React.createContext(
    (defaultState, defaultSetter)
)

module Provider= {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

