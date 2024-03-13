/* *****************************************************************************
 * NightTypeCodec
 */

type nightType =
  | Dawn
  | Night

let nightTypeToString = (nightType: nightType): string => {
  switch nightType {
  | Dawn => "Dawn"
  | Night => "Night"
  }
}

let nightTypeFromString = (value: string): option<nightType> => {
  switch value {
  | "Dawn" => Some(Dawn)
  | "Night" => Some(Night)
  | _ => None
  }
}

let encoder: Decco.encoder<nightType> = (nightType: nightType): Js.Json.t => {
  nightType->nightTypeToString->Decco.stringToJson
}

let decoder: Decco.decoder<nightType> = (json: Js.Json.t): Belt.Result.t<
  nightType,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->nightTypeFromString {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<nightType> = (encoder, decoder)

@decco type t = @decco.codec(codec) nightType
