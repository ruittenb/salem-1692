/* *****************************************************************************
 * PhaseCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | DaytimeWaitingPhase
  | NightWaitingPhase
  | NightChoiceWitchesPhase
  | NightConfirmWitchesPhase
  | NightChoiceConstablePhase
  | NightConfirmConstablePhase

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")
