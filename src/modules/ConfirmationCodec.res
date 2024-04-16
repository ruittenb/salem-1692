/* *****************************************************************************
 * ConfirmationCodec
 */

// generates the functions confirmationToJs() and confirmationFromJs()
@deriving(jsConverter)
type confirmation = [
  | #Yes
  | #No
  | #Unconfirmed
]

let encoder: Decco.encoder<confirmation> = (confirmation: confirmation): Js.Json.t => {
  confirmation->confirmationToJs->Decco.stringToJson
}

let decoder: Decco.decoder<confirmation> = (json: Js.Json.t): Belt.Result.t<
  confirmation,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->confirmationFromJs {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<confirmation> = (encoder, decoder)

@decco type t = @decco.codec(codec) confirmation
