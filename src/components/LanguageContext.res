
/** ****************************************************************************
 * LanguageContext
 */

open Types

let context = React.createContext(EN_US) // default value (not initial!)

module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => { // initial values
        React.createElement(provider, { "value": value, "children": children })
    }
}

