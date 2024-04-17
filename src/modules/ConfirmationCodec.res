/* *****************************************************************************
 * ConfirmationCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("Yes") Yes
  | @spice.as("No") No
  | @spice.as("Unconfirmed") Unconfirmed

let encoded = Yes->t_encode
Js.log2("encoded:", encoded)

let decoded = Js.Json.string("No")->t_decode
