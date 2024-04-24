/* *****************************************************************************
 * NumerusCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | One
  | More

let toString = (x: t) => x->t_encode->Js.Json.decodeString->Belt.Option.getWithDefault("invalid")
