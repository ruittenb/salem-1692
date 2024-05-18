/* *****************************************************************************
 * LanguageCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t = [
  | @spice.as("en_US") #en_US
  | @spice.as("es_ES") #es_ES
  | @spice.as("pt_BR") #pt_BR
  | @spice.as("fr_FR") #fr_FR
  | @spice.as("it_IT") #it_IT
  | @spice.as("de_DE") #de_DE
  | @spice.as("nl_NL") #nl_NL
  | @spice.as("uk_UA") #uk_UA
  | @spice.as("hu_HU") #hu_HU
  | @spice.as("zh_CN") #zh_CN
  | @spice.as("ja_JP") #ja_JP
  | @spice.as("ko_KR") #ko_KR
  | @spice.as("th_TH") #th_TH
]

let toString = (x: t) => (x :> string)

//let fromString = (x: string) =>
//  x
//  ->Belt.Option.map(Js.Json.string)
//  ->Belt.Option.flatMap(language => language->LanguageCodec.t_decode->Utils.resultToOption) // option<LanguageCodec.t>
//  ->Belt.Option.getWithDefault(gameState.language)

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
  | #hu_HU
  | #zh_CN
  | #ja_JP
  | #ko_KR
  | #th_TH =>
    language->toString->Js.String2.substring(~from=0, ~to_=2)
  }
}
