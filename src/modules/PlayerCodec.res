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
  player->toString->Js.Json.string
}

let t_decode = (playerJson: Js.Json.t): Belt.Result.t<t, Spice.decodeError> => {
  switch playerJson->Js.Json.decodeString->Belt.Option.getWithDefault("") {
  | "Nobody" => Belt.Result.Ok(Nobody)
  | "Undecided" => Belt.Result.Ok(Undecided)
  | playerStr =>
    if playerStr->Js.String2.startsWith("Player:") {
      Belt.Result.Ok(Player(playerStr->Js.String2.substringToEnd(~from=7)))
    } else {
      Spice.error("Spice Decoding Error", playerJson)
    }
  }
}
