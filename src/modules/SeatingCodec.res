/* *****************************************************************************
 * SeatingCodec
 */

/*
 * How are the players seated around the table?
 *
 *           even nr. players          odd nr. players
 *        ----------------------    ----------------------
 *        TwoAtTop      OneAtTop    OneAtTop      TwoAtTop
 *        --------      --------    --------      --------
 *          o   o          o            o          o   o
 *          o   o        o   o        o   o        o   o
 *          o   o        o   o        o   o        o   o
 *          o   o          o          o   o          o
 */

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("OneAtTop") OneAtTop
  | @spice.as("TwoAtTop") TwoAtTop

let toString = (x: t) => x->t_encode->JSON.Decode.string->Option.getOr("invalid")
