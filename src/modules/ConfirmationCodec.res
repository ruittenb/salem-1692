/* *****************************************************************************
 * ConfirmationCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | Yes
  | No
  | Unconfirmed

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")
