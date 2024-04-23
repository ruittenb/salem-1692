/* *****************************************************************************
 * NightTypeCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | Dawn
  | Night

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")