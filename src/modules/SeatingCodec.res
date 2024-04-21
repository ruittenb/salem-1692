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
type seating =
  | OneAtTop
  | TwoAtTop
