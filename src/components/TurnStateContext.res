
/** ****************************************************************************
 * TurnStateContext
 */

open Types

let defaultSetter: turnStateSetter = (_: turnState => turnState) => ()
let defaultState: turnState = {
    nrWitches: One,
    choiceWitches: "",
    choiceConstable: None,
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

