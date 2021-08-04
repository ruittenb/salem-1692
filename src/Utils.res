
/** ****************************************************************************
 * Utils
 */

/**
 * converts [ Some(3), Some(6), None, Some(-1), None ]
 * into     [ 3, 6, -1 ]
 */
let arrayFilterSome = (
    elements: array<option<'a>>
): array<'a> => {
    []->Js.Array2.concatMany(
        elements->Js.Array2.map(
            element => switch element {
                | Some(x) => [ x ]
                | None    => []
            }
        )
    )
}

/**
 * like Js.Option.andThen(), but data-first
 */
let option2AndThen = (
    maybeValue: option<'a>,
    fn: ('a => option<'b>)
): option<'b> => {
    Js.Option.andThen((. value) => fn(value), maybeValue)
}

/**
 * like Js.Option.map(), but data-first
 */
let option2Map = (
    maybeValue: option<'a>,
    fn: ('a => 'b)
): option<'b> => {
    Js.Option.map((. value) => fn(value), maybeValue)
}

/**
 * calls a function that may throw an exception and converts
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

