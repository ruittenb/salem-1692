/* *****************************************************************************
 * ConfirmationCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("Yes") Yes
  | @spice.as("No") No
  | @spice.as("Unconfirmed") Unconfirmed

let toString = (x: t) => x->t_encode->JSON.Decode.string->Option.getOr("invalid")
