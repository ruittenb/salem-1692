/* *****************************************************************************
 * TurnStateContext
 */

open Types

let defaultSetter: turnStateSetter = (_: turnState => turnState) => ()
let defaultValue: turnState = {
  nrWitches: One,
  nightType: Dawn,
  choiceWitches: None,
  choiceConstable: None,
}
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
