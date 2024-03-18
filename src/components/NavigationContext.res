/* *****************************************************************************
 * NavigationContext
 */

open Types

let defaultSetter: navigationSetter = (_: option<page> => option<page>) => ()
let defaultValue: option<page> = None
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
