/** ****************************************************************************
 * GameTypeCodec
 */

@decco type gameId = string

type gameType =
    | StandAlone
    | ConnectingAsMaster
    | ConnectingAsSlave
    | Master(gameId, Types.dbConnection)
    | Slave(gameId, Types.dbConnection)

let encoder: Decco.encoder<gameType> = (gameType: gameType): Js.Json.t => {
    let gameTypeString = switch gameType {
        | StandAlone
        | ConnectingAsMaster
        | ConnectingAsSlave  => "StandAlone"
        | Master(gameId, _)  => "Master:" ++ gameId
        | Slave(gameId, _)   => "Slave:" ++ gameId
    }
    gameTypeString->Decco.stringToJson
}

let gameTypeFromString = (value: string): option<gameType> => {
    let segments: array<string>  = value->Js.String2.split(":") // returns at least one segment
    let mainType: option<string> = segments->Belt.Array.get(0)
    let gameId: option<gameId>   = segments->Belt.Array.get(1)

    switch (mainType, gameId) {
        | (Some("StandAlone"), _)     => Some(StandAlone)
        | (Some("Master"), Some(_id)) => Some(StandAlone) // Some(Master(id)) // FIXME
        | (Some("Slave"), Some(_id))  => Some(StandAlone) // Some(Slave(id)) // FIXME
        | (Some("Master"), None)
        | (Some("Slave"), None)
        | (Some(_), _)
        | (None, _)                   => None
    }
}

let decoder: Decco.decoder<gameType> = (
    json: Js.Json.t
): Belt.Result.t<gameType, Decco.decodeError> => {
    switch (json->Decco.stringFromJson) {
        | Belt.Result.Ok(v) => switch (v->gameTypeFromString) {
            | None => Decco.error(~path="", "Invalid enum " ++ v, json)
            | Some(v) => v->Ok
        }
        | Belt.Result.Error(_) as err => err
    }
}

let codec: Decco.codec<gameType> = (encoder, decoder)

@decco type t = @decco.codec(codec) gameType

