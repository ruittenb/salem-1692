
/** ****************************************************************************
 * DbConnectionContext
 */

open Types.FbDb

let defaultSetter: dbConnectionSetter = (_: dbConnection => dbConnection) => ()
let defaultValue: dbConnection = Firebase.connect()

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

