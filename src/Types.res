
/** ****************************************************************************
 * Types
 */

type clickHandler = ReactEvent.Mouse.t => unit
type mediaHandler = ReactEvent.Media.t => unit

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
    | DaytimeReveal
    | Close

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
    | Silence1s
    | Silence2s

type scenarioStep =
    | Speech(audioSpeech)
    | Effect(audioEffect)
    | ChooseWitch
    | ConfirmWitch
    | ChooseConstable
    | ConfirmConstable

type scenario = array<scenarioStep>

