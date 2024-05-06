/* *****************************************************************************
 * Translator
 */

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

// formatString('Hello {0}, your order {1} has been shipped.', ['John', '1022'])
let formatString = (template: string, args: array<string>): string => {
  args->Js.Array2.reducei((acc: string, item: string, index: int) => {
    acc->Js.String2.replace("{" ++ index->Belt.Int.toString ++ "}", item)
  }, template)
}

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
  | #hu_HU => lookup(HU_HU.table, message, "Hungarian")
  | #zh_CN => lookup(ZH_CN.table, message, "Chinese")
  | #ja_JP => lookup(JA_JP.table, message, "Japanese")
  | #ko_KR => lookup(KO_KR.table, message, "Korean")
  | #th_TH => lookup(TH_TH.table, message, "Thai")
  }
}
