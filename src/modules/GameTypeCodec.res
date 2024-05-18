/* *****************************************************************************
 * GameTypeCodec
 */

@spice
type gameId = string

// generates the functions t_encode() and t_decode()
@spice
type t =
  | StandAlone
  | Master(gameId)
  | Slave(gameId)