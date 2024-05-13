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

let toString = (x: t): string => {
  switch x {
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

let t_encode = (x: t) => {
  x->toString->Js.Json.string
}

let t_decode = (x: Js.Json.t): Belt.Result.t<t, Spice.decodeError> => {
  switch x->Js.Json.decodeString->Belt.Option.getWithDefault("") {
  | "Nobody" => Belt.Result.Ok(Nobody)
  | "Undecided" => Belt.Result.Ok(Undecided)
  | value =>
    if value->Js.String2.startsWith("Player:") {
      Belt.Result.Ok(Player(value->Js.String2.substringToEnd(~from=7)))
    } else {
      Spice.error("Spice Decoding Error", x)
    }
  }
}