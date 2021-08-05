
/** ****************************************************************************
 * Translator
 */

open Types

let getLanguageCode = (language: language): string => {
    switch language {
        | EN_US => "en_US"
        | NL_NL => "nl_NL"
        | ES_ES => "es_ES"
    }
}

let getLanguageByCode = (language: string): option<language> => {
    switch language {
        | "en_US" => Some(EN_US)
        | "nl_NL" => Some(NL_NL)
        | "es_ES" => Some(ES_ES)
        | _ => None
    }
}

let lookup = (table: Js.Dict.t<string>, message: string, languageName: string) => {
    switch Js.Dict.get(table, message) {
        | Some(translation) => translation
        | None              => {
            Js.log4("Warning: no translation found for", message, "in", languageName)
            message
        }
    }
}

let getTranslator = (language: language, message: string): string => {
    switch language {
        | EN_US => lookup(EN_US.table, message, "English")
        | NL_NL => lookup(NL_NL.table, message, "Dutch")
        | ES_ES => lookup(ES_ES.table, message, "Spanish")
    }
}

