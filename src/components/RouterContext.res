/* *****************************************************************************
 * RouterContext
 */

open Types

let defaultSetter: routerSetter = (_: page => page) => ()
let defaultValue: page = Title
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
