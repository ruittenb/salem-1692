/* *****************************************************************************
 * ConfirmationCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("Yes") Yes
  | @spice.as("No") No
  | @spice.as("Unconfirmed") Unconfirmed
