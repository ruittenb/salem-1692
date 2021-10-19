
/** ****************************************************************************
 * Utils
 */

let identity = (arg: 'a): 'a => arg

/**
 * Log a message to console with error formatting
 */
let logError = (msg: string): unit => {
    Js.log2("%cError: " ++ msg, Constants.consoleErrorFormatting)
}

/**
 * Log a message to console only if debug flag is set
 */
let logDebug = (msg: string): unit => {
    if (Constants.debug) {
        Js.log(msg)
    }
}

/**
 * Extract message from exception
 */
let getExceptionMessage = (error: exn): string => {
    error
        ->Js.Exn.asJsExn
        ->Belt.Option.flatMap(Js.Exn.message)
        ->Belt.Option.getWithDefault("An unknown error occurred")
}

/**
 * Pick a random element from a set.
 */
let pickRandomElement = (set: array<'a>, default: 'a): 'a => {
    let index = Js.Math.random_int(0, set->Belt.Array.length)
    set ->Belt.Array.get(index)
        ->Belt.Option.getWithDefault(default)
}

/**
 * Calls a function that may throw an exception.
 * The result is converted into an option.
 */
let safeExec = (
    functionThatMayThrow: () => 'a
): option<'a> => {
    try {
        functionThatMayThrow()->Some
    } catch {
        | error =>
            error
                ->getExceptionMessage
                ->logError
            None
    }
}

/**
 * Tries to find a DOM node in the document.  Returns a Result.
 */
let safeQuerySelector = (
    elementId: string
): Belt.Result.t<Dom.element, string> => {
    try {
        switch (ReactDOM.querySelector("#" ++ elementId)) {
            | Some(element) => Ok(element)
            | None          => Error("Cannot find DOM element with id '" ++ elementId ++ "'")
        }
    } catch {
        | error => error
            ->getExceptionMessage
            ->Error
    }
}

/**
 * Replaces a value with another one.
 *
 * Example:
 * fn1()->replaceWith(React.null)
 */
let replaceWith = (
    _first: 'a,
    second: 'b
): 'b => {
    second
}

/**
 * Convert [ Some(3), Some(6), None, Some(-1), None ] into [ 3, 6, -1 ]:
 * use Belt.Array.keepMap(identity)
 *
 *
 * Call function if Some(x):
 * use Belt.Option.forEach()
 *
 *
 * Js.Option.andThen(), but data-first:
 * use Belt.Option.flatMap()
 *
 *
 * Js.Option.map(), but data-first:
 * use Belt.Option.map()
 */

