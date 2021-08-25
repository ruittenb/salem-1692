
/** ****************************************************************************
 * Translator
 */

open Types

let lookup = (table: Js.Dict.t<string>, message: string) => {
    switch Js.Dict.get(table, message) {
        | Some(translation) => translation
        | None              => message
    }
}

let getTranslator = (language: language, message: string): string => {
    switch language {
        | EN_US => lookup(EN_US.table, message)
        | NL_NL => lookup(NL_NL.table, message)
        | ES_ES => lookup(ES_ES.table, message)
    }
}

