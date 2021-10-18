
/** ****************************************************************************
 * DbConnectionContext
 */

open Types.FbDb

let defaultSetter: dbConnectionSetter = (_: maybeDbConnection => maybeDbConnection) => ()
let defaultValue: maybeDbConnection = None

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

