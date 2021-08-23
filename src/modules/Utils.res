
/** ****************************************************************************
 * Utils
 */

let identity = (arg: 'a): 'a => arg

/**
 * Calls a function that may throw an exception and converts
 * the result into an option<'a>
 */
let safeExec = (
    functionThatMayThrow: () => 'a
): option<'a> => {
    try {
        functionThatMayThrow()->Some
    } catch {
        | _ => None
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

