
/** ****************************************************************************
 * PhaseCodec
 */

// generates the functions phaseToJs() and phaseFromJs()
@deriving(jsConverter)
@decco type phase = [
    | #DaytimeWaiting
    | #NightWaiting
    | #NightChoiceWitches
    | #NightConfirmWitches
    | #NightChoiceConstable
    | #NightConfirmConstable
]

let encoder: Decco.encoder<phase> = (phase: phase): Js.Json.t => {
    phase->phaseToJs->Decco.stringToJson
}

// note: type Decco.decodeError has members
// - path: string
// - message: string
// - value: Js.Json.t

let decoder: Decco.decoder<phase> = (
    json: Js.Json.t
): Belt.Result.t<phase, Decco.decodeError> => {
    switch (json->Decco.stringFromJson) {
        | Belt.Result.Ok(v) => switch (v->phaseFromJs) {
            | None => Decco.error(~path="", "Invalid enum " ++ v, json)
            | Some(v) => v->Ok
        }
        | Belt.Result.Error(_) as err => err
    }
}

let codec: Decco.codec<phase> = (encoder, decoder)

@decco type t = @decco.codec(codec) phase

