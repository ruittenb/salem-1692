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
  let provider = React.Context.provider(context)

  @react.component
  let make = (~value, ~children) => {
    React.createElement(provider, {"value": value, "children": children})
  }
}
