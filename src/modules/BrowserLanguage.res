/* *****************************************************************************
 * BrowserLanguage
 */

open Types
open Constants

let secondHalfRe = %re("/[-_].*/")

let getLanguage = (): option<LanguageCodec.t> => {
  switch navigator->language->String.replaceRegExp(secondHalfRe, "") {
  | "en" => Some(#en_US)
  | "es" => Some(#es_ES)
  | "fr" => Some(#fr_FR)
  | "pt" => Some(#pt_BR)
  | "it" => Some(#it_IT)
  | "de" => Some(#de_DE)
  | "nl" => Some(#nl_NL)
  //| "uk" => Some(#uk_UA)
  //| "hu" => Some(#hu_HU)
  //| "zh" => Some(#zh_CN)
  //| "ja" => Some(#ja_JP)
  //| "ko" => Some(#ko_KR)
  //| "th" => Some(#th_TH)
  | _ => None
  }
}
