
/** ****************************************************************************
 * LocalStorage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Dom.Storage2

let setItem = (key: string, value: string): unit => {
    localStorage->setItem(key, value)
}

let getItem = (key: string): option<string> => {
    localStorage->getItem(key)
}

