/** ****************************************************************************
 * NavigationContext
 */

open Types

let defaultSetter: navigationSetter = (_: option<page> => option<page>) => ()
let defaultValue: option<page> = None

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

