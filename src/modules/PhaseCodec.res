/* *****************************************************************************
 * PhaseCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("DaytimeWaitingPhase") DaytimeWaitingPhase
  | @spice.as("NightWaitingPhase") NightWaitingPhase
  | @spice.as("NightChoiceWitchesPhase") NightChoiceWitchesPhase
  | @spice.as("NightConfirmWitchesPhase") NightConfirmWitchesPhase
  | @spice.as("NightChoiceConstablePhase") NightChoiceConstablePhase
  | @spice.as("NightConfirmConstablePhase") NightConfirmConstablePhase

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")
