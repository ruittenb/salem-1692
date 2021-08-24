
/** ****************************************************************************
 * Translator
 */

@@warning("-33") // Unused 'open Types'

open Types

let lookup = (table: Js.Dict.t<string>, message: string, languageName: string) => {
    switch Js.Dict.get(table, message) {
        | Some(translation) => translation
        | None              => {
            Js.log4("Warning: no translation found for", message, "in", languageName)
            message
        }
    }
}

let getTranslator = (language: LanguageCodec.t, message: string): string => {
    switch language {
        // modules EN_US etc. need to start with capital letters
        | #en_US => lookup(EN_US.table, message, "English")
        | #nl_NL => lookup(NL_NL.table, message, "Dutch")
        | #es_ES => lookup(ES_ES.table, message, "Spanish")
    }
}

