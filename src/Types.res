
/** ****************************************************************************
 * Types: Type declarations
 */

type either<'t, 'v> =
    | Left('t)
    | Right('v)

type language =
    | NL
    | EN

type page =
    | Title
    | Players
    | Turn
    | NightWitch
    | NightConstable

type buttonType =
    | RegularFirst
    | RegularSecond
    | RegularThird

type player = {
    name: string
}

type state = {
    currentPage    : page,
    currentLang    : language,
    currentPlayers : array<player>
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

