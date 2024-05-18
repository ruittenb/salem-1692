/* *****************************************************************************
 * NumerusCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("One") One
  | @spice.as("More") More

let toString = (x: t) =>
  switch x {
  | One => "One"
  | More => "More"
  }
