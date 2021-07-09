
/** ****************************************************************************
 * Context
 */

open Types

module Locale = {
    let context = React.createContext(NL_NL)

    module Provider ={
        let provider = React.Context.provider(context)

        @react.component
        let make = (~value, ~children) => {
            React.createElement(provider, { "value": value, "children": children })
        }
    }
}

