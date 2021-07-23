
/** ****************************************************************************
 * TurnStateContext
 */

open Types

let defaultSetter: turnStateSetter = (_: turnState => turnState) => ()
let defaultState: turnState = {
    nrWitches: 0,
    hasConstable: false,
    choiceWitches: "",
    choiceConstable: "",
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

