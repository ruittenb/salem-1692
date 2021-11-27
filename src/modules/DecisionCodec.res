
/** ****************************************************************************
 * DecisionCodec
 */

// generates the functions decisionToJs() and decisionFromJs()
@deriving(jsConverter)
type decision = [
    | #Yes
    | #No
    | #Undecided
]

let encoder: Decco.encoder<decision> = (decision: decision): Js.Json.t => {
    decision->decisionToJs->Decco.stringToJson
}

let decoder: Decco.decoder<decision> = (
    json: Js.Json.t
): Belt.Result.t<decision, Decco.decodeError> => {
    switch (json->Decco.stringFromJson) {
        | Belt.Result.Ok(v) => switch (v->decisionFromJs) {
            | None => Decco.error(~path="", "Invalid enum " ++ v, json)
            | Some(v) => v->Ok
        }
        | Belt.Result.Error(_) as err => err
    }
}

let codec: Decco.codec<decision> = (encoder, decoder)

@decco type t = @decco.codec(codec) decision

