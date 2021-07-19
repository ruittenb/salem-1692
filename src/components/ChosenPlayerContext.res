
/** ****************************************************************************
 * ChosenPlayerContext
 */

open Types

let defaultPlayerSetter: chosenPlayerSetter = (_: string => string) => ()

let default: (string, chosenPlayerSetter) = ("", defaultPlayerSetter)
let contextWitch     = React.createContext(default)
let contextConstable = React.createContext(default)

module ProviderWitch = {
    let provider = React.Context.provider(contextWitch)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

module ProviderConstable = {
    let provider = React.Context.provider(contextConstable)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

