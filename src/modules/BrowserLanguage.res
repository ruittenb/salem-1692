/* *****************************************************************************
 * BrowserLanguage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Constants

let secondHalfRe = %re("/[-_].*/")

let getLanguage = (): option<LanguageCodec.t> => {
  switch navigator->language->Js.String2.replaceByRe(secondHalfRe, "") {
  | "es" => Some(#es_ES)
  | "fr" => Some(#fr_FR)
  | "pt" => Some(#pt_BR)
  | "it" => Some(#it_IT)
  | "de" => Some(#de_DE)
  | "nl" => Some(#nl_NL)
  | "uk" => Some(#uk_UA)
  | "ja" => Some(#ja_JP)
  | "ko" => Some(#ko_KR)
  | "en" => Some(#en_US)
  | _ => None
  }
}
