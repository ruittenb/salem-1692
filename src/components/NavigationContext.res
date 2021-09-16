
/** ****************************************************************************
 * NavigationContext
 */

open Types

let defaultNavigationSetter: navigationSetter = (_: option<page> => option<page>) => ()
let defaultNavigation: option<page> = None

let context = React.createContext(
    (defaultNavigation, defaultNavigationSetter)
)

module Provider= {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~value, ~children) => {
        React.createElement(provider, { "value": value, "children": children })
    }
}

