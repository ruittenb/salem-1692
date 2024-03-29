/* *****************************************************************************
 * LanguageCodec
 */

// generates the functions languageToJs() and languageFromJs()
@deriving(jsConverter)
type language = [
  | #en_US
  | #es_ES
  | #pt_BR
  | #fr_FR
  | #it_IT
  | #de_DE
  | #nl_NL
  | #uk_UA
  | #zh_CN
  | #ja_JP
  | #ko_KR
  | #th_TH
]

let encoder: Decco.encoder<language> = (language: language): Js.Json.t => {
  language->languageToJs->Decco.stringToJson
}

// note: type Decco.decodeError has members
// - path: string
// - message: string
// - value: Js.Json.t

let decoder: Decco.decoder<language> = (json: Js.Json.t): Belt.Result.t<
  language,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->languageFromJs {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<language> = (encoder, decoder)

@decco type t = @decco.codec(codec) language

let getHtmlLanguage = (language: t): string => {
  switch language {
  | #en_US
  | #es_ES
  | #pt_BR
  | #fr_FR
  | #it_IT
  | #de_DE
  | #nl_NL
  | #uk_UA
  | #zh_CN
  | #ja_JP
  | #ko_KR
  | #th_TH =>
    language->languageToJs->Js.String2.substring(~from=0, ~to_=2)
  }
}
