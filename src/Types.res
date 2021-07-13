
/** ****************************************************************************
 * Types: Type declarations
 */

type clickHandler = ReactEvent.Mouse.t => unit

type either<'t, 'v> =
    | Left('t)
    | Right('v)

type language =
    | NL_NL
    | EN_US
    | ES_ES

type player = string
type players = array<player>

type page =
    | Title
    | Setup
    | SetupLanguage
    | SetupPlayers
    | Credits
    | Daytime
    | FirstNight
    | OtherNightWithConstable
    | OtherNightNoConstable
    | Exit

type audioSpeech =
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

type audioEffect =
    | ChurchBell
    | Rooster
    | Silence

type scenarioStep =
    | Speech(audioSpeech)
    | Effect(audioEffect)
    | ChooseWitch
    | ConfirmWitch
    | ChooseConstable
    | ConfirmConstable

type scenario = array<scenarioStep>

