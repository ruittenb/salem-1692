
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
    elements                                           // array<option<'a>>
        ->Js.Array2.filter(Js.Option.isSome)           // array<Some('a)>
        ->Js.Array2.map(Js.Option.getWithDefault(""))  // array<'a>
    // The default is irrelevant since all values are Some(x)
}

/**
 * Call function if Some(x):
 * use Belt.Option.forEach()
 *
 * Js.Option.andThen(), but data-first:
 * use Belt.Option.flatMap() instead
 *
 * Js.Option.map(), but data-first:
 * use Belt.Option.map() instead
 */

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

