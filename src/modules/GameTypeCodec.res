/* *****************************************************************************
 * GameTypeCodec
 */

@spice
type gameId = string

// generates the functions t_encode() and t_decode()
@spice
type t =
  | @spice.as("StandAlone") StandAlone
  | @spice.as("Master") Master(gameId)
  | @spice.as("Slave") Slave(gameId)
