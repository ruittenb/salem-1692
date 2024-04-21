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
