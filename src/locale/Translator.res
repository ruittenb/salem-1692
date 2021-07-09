
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
        | EN_US => message
        | NL_NL => lookup(NL_NL.table, message)
    }
}

