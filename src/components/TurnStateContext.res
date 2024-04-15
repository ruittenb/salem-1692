/* *****************************************************************************
 * TurnStateContext
 */

open Types

let defaultSetter: turnStateSetter = (_: turnState => turnState) => ()
let defaultValue: turnState = {
  nrWitches: One,
  nightType: Dawn,
  choiceWitches: PlayerCodec.Undecided,
  choiceConstable: PlayerCodec.Undecided,
}
let context = React.createContext((defaultValue, defaultSetter))

module Provider = {
  let make = React.Context.provider(context)
}
