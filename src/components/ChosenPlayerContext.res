
/** ****************************************************************************
 * ChosenPlayerContext
 */

open Types

let defaultPlayerSetter: chosenPlayerSetter = (_: string => string) => ()

let default: (string, chosenPlayerSetter) = ("", defaultPlayerSetter)
let context1 = React.createContext(default)
let context2 = React.createContext(default)

module Provider1 = {
    let provider = React.Context.provider(context1)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

module Provider2 = {
    let provider = React.Context.provider(context2)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

