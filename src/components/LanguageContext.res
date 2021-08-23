
/** ****************************************************************************
 * LanguageContext
 */

@@warning("-33") // Unused 'open Types'

open Types

let defaultLanguage: LanguageCodec.t = #EN_US
let defaultTranslator = Translator.getTranslator(defaultLanguage)

let context = React.createContext(
    (defaultLanguage, defaultTranslator)
)

module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => { // initial values
        React.createElement(provider, { "value": value, "children": children })
    }
}

