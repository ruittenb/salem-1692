
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
    | A_TownGoSleep
    | B_WitchWakeUp
    | E_WitchGoSleep
    | G_WitchesWakeUp
    | J_WitchesGoSleep
    | M_ConstableWakeUp
    | N_ConstableGoSleep
    | Z_TownWakeUp

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

