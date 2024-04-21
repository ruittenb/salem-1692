/* *****************************************************************************
 * LanguageCodec
 */

// generates the functions t_encode() and t_decode()
@spice
type t = [
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
  | #th_TH
]

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
    language->languageToJs->Js.String2.substring(~from=0, ~to_=2)
  }
}
