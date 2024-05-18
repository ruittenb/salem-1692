/* *****************************************************************************
 * NightTypeCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("Dawn") Dawn
  | @spice.as("Night") Night

let toString = (x: t): string =>
  switch x {
  | Dawn => "Dawn"
  | Night => "Night"
  }
