
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
    | Setup // language, player names, nr. witches
    | SetupPlayers
    | Turn
    | NightWitch
    | NightConstable

type track =
    | TownGoToSleep
    | WitchWakeUp
    | WitchesWakeUp
    | WitchDecideCat
    | WitchesDecideCat
    | WitchesDecideMurder
    | WitchGoToSleep
    | WitchesGoToSleep
    | ConstableWakeUp
    | ConstableGoToSleep
    | TownWakeUp

type player = {
    name: string
}

type state = {
    currentPage    : page,
    currentPlayers : array<player>,
    currentLang    : language,
    translator     : string => string,
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

