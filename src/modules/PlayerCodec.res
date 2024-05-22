/* *****************************************************************************
 * PlayerCodec
 */

// generates the functions playerName_encode() and playerName_decode()
@spice
type playerName = string

// spice cannot generate the functions t_encode() and t_decode() for variants with arguments.
// we will define these functions below.
type t =
  | Player(playerName)
  | Nobody
  | Undecided

let toString = (player: t): string => {
  switch player {
  | Player(playerName) => "Player:" ++ playerName
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

let t_encode = (player: t) => {
  player->toString->JSON.String
}

let t_decode = (playerJson: JSON.t): Belt.Result.t<t, Spice.decodeError> => {
  switch playerJson->JSON.Decode.string->Option.getOr("") {
  | "Nobody" => Belt.Result.Ok(Nobody)
  | "Undecided" => Belt.Result.Ok(Undecided)
  | playerStr =>
    if playerStr->String.startsWith("Player:") {
      Belt.Result.Ok(Player(playerStr->String.substringToEnd(~start=7)))
    } else {
      Spice.error("Spice Decoding Error", playerJson)
    }
  }
}
