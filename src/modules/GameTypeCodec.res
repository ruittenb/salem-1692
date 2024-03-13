/* *****************************************************************************
 * GameTypeCodec
 */

@decco type gameId = string

type gameType =
  | StandAlone
  | Master(gameId)
  | Slave(gameId)

let encoder: Decco.encoder<gameType> = (gameType: gameType): Js.Json.t => {
  let gameTypeString = switch gameType {
  | StandAlone => "StandAlone"
  | Master(gameId) => "Master:" ++ gameId
  | Slave(gameId) => "Slave:" ++ gameId
  }
  gameTypeString->Decco.stringToJson
}

let gameTypeFromString = (value: string): option<gameType> => {
  let segments: array<string> = value->Js.String2.split(":") // returns at least one segment
  let mainType: option<string> = segments->Belt.Array.get(0)
  let gameId: option<gameId> = segments->Belt.Array.get(1)

  switch (mainType, gameId) {
  | (Some("StandAlone"), _) => Some(StandAlone)
  | (Some("Master"), Some(id)) => Some(Master(id))
  | (Some("Slave"), Some(id)) => Some(Slave(id))
  | (Some("Master"), None)
  | (Some("Slave"), None)
  | (Some(_), _)
  | (None, _) =>
    None
  }
}

let decoder: Decco.decoder<gameType> = (json: Js.Json.t): Belt.Result.t<
  gameType,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->gameTypeFromString {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<gameType> = (encoder, decoder)

@decco type t = @decco.codec(codec) gameType
