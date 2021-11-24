
/** ****************************************************************************
 * DbConnectionContext
 */

open Types

let defaultSetter: dbConnectionSetter = (_: dbConnectionStatus => dbConnectionStatus) => ()
let defaultValue: dbConnectionStatus = NotConnected

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

