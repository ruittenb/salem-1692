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

let toString = (x: t): string => {
  switch x {
  | Player(playerName) => `["Player", "` ++ playerName ++ `"]`
  | Nobody => "Nobody"
  | Undecided => "Undecided"
  }
}
let map = (player: t, mapFn: playerName => playerName) => {
  switch player {
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
