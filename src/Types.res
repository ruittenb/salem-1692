
/** ****************************************************************************
 * Types: Type declarations
 */

type either<'t, 'v> =
    | Left('t)
    | Right('v)

type language =
    | NL_NL
    | EN_US
    | ES_ES

type page =
    | Title
    | Setup // language, player names, nr. witches, credits
    | SetupLanguage
    | SetupPlayers
    | Credits
    | DayTime
    | FirstNight
    | OtherNightWithConstable
    | OtherNightNoConstable
    | NightWitch
    | Exit

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
    currentPlayers : array<player>,
}

