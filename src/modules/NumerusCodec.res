/** ****************************************************************************
 * NumerusCodec
 */

@decco type numerus =
    | One
    | More

let numerusToJs = (n: numerus): string => switch n {
    | One  => "One"
    | More => "More"
}

let numerusFromJs = (n: string): Js.Option.t<numerus> => switch n {
    | "One"  => Some(One)
    | "More" => Some(More)
    | _      => None
}

let encoder: Decco.encoder<numerus> = (numerus: numerus): Js.Json.t => {
    numerus->numerusToJs->Decco.stringToJson
}

// note: type Decco.decodeError has members
// - path: string
// - message: string
// - value: Js.Json.t

let decoder: Decco.decoder<numerus> = (
    json: Js.Json.t
): Belt.Result.t<numerus, Decco.decodeError> => {
    switch (json->Decco.stringFromJson) {
        | Belt.Result.Ok(v) => switch (v->numerusFromJs) {
            | None => Decco.error(~path="", "Invalid enum " ++ v, json)
            | Some(v) => v->Ok
        }
        | Belt.Result.Error(_) as err => err
    }
}

let codec: Decco.codec<numerus> = (encoder, decoder)

@decco type t = @decco.codec(codec) numerus

