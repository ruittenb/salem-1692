
/** ****************************************************************************
 * LanguageContext
 */

open Types

let context = React.createContext(EN_US) // default value

module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

