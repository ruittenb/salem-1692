/* *****************************************************************************
 * PhaseCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("DaytimeWaiting") DaytimeWaitingPhase
  | @spice.as("NightWaiting") NightWaitingPhase
  | @spice.as("NightChoiceWitches") NightChoiceWitchesPhase
  | @spice.as("NightConfirmWitches") NightConfirmWitchesPhase
  | @spice.as("NightChoiceConstable") NightChoiceConstablePhase
  | @spice.as("NightConfirmConstable") NightConfirmConstablePhase

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")
