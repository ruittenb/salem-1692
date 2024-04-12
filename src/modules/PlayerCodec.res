/* *****************************************************************************
 * PlayerCodec
 */

@decco type playerName = string

type playerType =
  | Player(playerName)
  | Nobody
  | Undecided

let map = (player1: playerType, mapFn: playerName => playerName) => {
  switch player1 {
  | Player(playerName) => Player(mapFn(playerName))
  | Nobody => Nobody
  | Undecided => Undecided
  }
}

let playerTypeToLocalizedString = (playerType: playerType, translator): string => {
  switch playerType {
  | Player(playerName) => playerName
  | Nobody => translator("Nobody-SUBJ")
  | Undecided => "Undecided"
  }
}

let playerTypeToString = (playerType: playerType): string => {
  switch playerType {
  | Player(playerName) => "Player:" ++ playerName
  | Nobody => "Nobody"
  | Undecided => "Undecided"
  }
}

let encoder: Decco.encoder<playerType> = (playerType: playerType): Js.Json.t => {
  playerType->playerTypeToString->Decco.stringToJson
}

let playerTypeFromString = (value: string): option<playerType> => {
  let segments: array<string> = value->Js.String2.split(":") // returns at least one segment
  let mainType: option<string> = segments->Belt.Array.get(0)
  let playerName: option<playerName> = segments->Belt.Array.get(1)

  switch (mainType, playerName) {
  | (Some("Undecided"), _) => Some(Undecided)
  | (Some("Nobody"), _) => Some(Nobody)
  | (Some("Player"), Some(name)) => Some(Player(name))
  | (Some("Player"), None)
  | (Some(_), _)
  | (None, _) =>
    None
  }
}

let decoder: Decco.decoder<playerType> = (json: Js.Json.t): Belt.Result.t<
  playerType,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->playerTypeFromString {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<playerType> = (encoder, decoder)

@decco type t = @decco.codec(codec) playerType