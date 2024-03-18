/* *****************************************************************************
 * DbConnectionContext
 */

open Types

let defaultSetter: dbConnectionSetter = (_: dbConnectionStatus => dbConnectionStatus) => ()
let defaultValue: dbConnectionStatus = NotConnected
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
