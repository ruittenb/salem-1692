
/** ****************************************************************************
 * LanguageCodec
 */

// generates the functions languageToJs() and languageFromJs()
@deriving(jsConverter)
type language = [
    | #nl_NL
    | #en_US
    | #es_ES
]

let encoder: Decco.encoder<language> = (lanugage: language): Js.Json.t => {
    lanugage->languageToJs->Decco.stringToJson
}

let decoder: Decco.decoder<language> = (
    json: Js.Json.t
): Belt.Result.t<language, Decco.decodeError> => {
    switch (json->Decco.stringFromJson) {
        | Belt.Result.Ok(v) => switch (v->languageFromJs) {
            | None => Decco.error(~path="", "Invalid enum " ++ v, json)
            | Some(v) => v->Ok
        }
        | Belt.Result.Error(_) as err => err
    }
}

let codec: Decco.codec<language> = (encoder, decoder)

@decco type t = @decco.codec(codec) language

