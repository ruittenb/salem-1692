
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
        | EN => message
        | NL => lookup(NL_NL.table, message)
    }
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

