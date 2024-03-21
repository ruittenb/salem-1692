/* *****************************************************************************
 * Translator
 */

@@warning("-33") // Unused 'open Types'

open Types

let p = "[Translator] "

let lookup = (table: Js.Dict.t<string>, message: string, languageName: string) => {
  switch Js.Dict.get(table, message) {
  | Some(translation) => translation
  | None => {
      Js.log(p ++ "Warning: no translation found for " ++ message ++ " in " ++ languageName)
      message
    }
  }
}

//const formatString = (template, ...args) => {
//  return template.replace(/{([0-9]+)}/g, function (match, index) {
//    return typeof args[index] === 'undefined' ? match : args[index];
//  });
//}
//console.log(formatString('Hello {0}, your order {1} has been shipped.', 'John', 10001));

let getTranslator = (language: LanguageCodec.t, message: string): string => {
  switch language {
  // modules EN_US etc. need to start with capital letters
  | #en_US => lookup(EN_US.table, message, "English")
  | #es_ES => lookup(ES_ES.table, message, "Spanish")
  | #pt_BR => lookup(PT_BR.table, message, "Portuguese")
  | #fr_FR => lookup(FR_FR.table, message, "French")
  | #it_IT => lookup(IT_IT.table, message, "Italian")
  | #de_DE => lookup(DE_DE.table, message, "German")
  | #nl_NL => lookup(NL_NL.table, message, "Dutch")
  | #uk_UA => lookup(UK_UA.table, message, "Ukrainian")
  | #ja_JP => lookup(JA_JP.table, message, "Japanese")
  | #ko_KR => lookup(KO_KR.table, message, "Korean")
  }
}
