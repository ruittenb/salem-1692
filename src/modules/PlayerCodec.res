/* *****************************************************************************
 * PlayerCodec
 */

// generates the functions playerName_encode() and playerName_decode()
@spice
type playerName = string

// generates the functions t_encode() and t_decode()
@spice
type t =
  | Player(playerName)
  | Nobody
  | Undecided

let map = (player1: t, mapFn: playerName => playerName) => {
  switch player1 {
  | Player(playerName) => Player(mapFn(playerName))
  | Nobody => Nobody
  | Undecided => Undecided
  }
}

let playerTypeToLocalizedString = (playerType: t, translator): string => {
  switch playerType {
  | Player(playerName) => playerName
  | Nobody => translator("Nobody-SUBJ")
  | Undecided => "Undecided"
  }
}

let playerTypeToString = (playerType: t): string => {
  switch playerType {
  | Player(playerName) => "Player:" ++ playerName
  | Nobody => "Nobody"
  | Undecided => "Undecided"
  }
}
