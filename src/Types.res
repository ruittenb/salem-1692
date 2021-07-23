
/** ****************************************************************************
 * Types
 */

type clickHandler = ReactEvent.Mouse.t => unit
type mediaHandler = ReactEvent.Media.t => unit

type chosenPlayerSetter = (string => string) => unit

type either<'t, 'v> =
    | Left('t)
    | Right('v)

type language =
    | NL_NL
    | EN_US
    | ES_ES

type player = string
type players = array<player>

/**
 * How are the players seated around the table?
 *
 *          o   o          o                  o               o   o
 *          o   o        o   o              o   o             o   o
 *          o   o        o   o              o   o             o   o
 *          o   o          o                o   o               o
 *
 *        TwoLines   TwoLinesTwoHeads   OneHeadTwoLines   TwoLinesOneHead
 */
type tableLayout =
    | TwoLines
    | TwoLinesTwoHeads
    | TwoLinesOneHead
    | OneHeadTwoLines

type page =
    | Title
    | Setup
    | SetupLanguage
    | SetupPlayers
    | Credits
    | Daytime
    | FirstNightOneWitch
    | FirstNightMoreWitches
    | OtherNightWithConstable
    | OtherNightNoConstable
    | DaytimeConfess
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
    | ChooseWitches
    | ConfirmWitches
    | ChooseConstable
    | ConfirmConstable

type scenario = array<scenarioStep>

type addressed =
    | Witch
    | Witches
    | Constable

type turnState = {
    nrWitches: int,
    hasConstable: bool,
    choiceWitches: string,
    choiceConstable: string,
}

type turnStateSetter = (turnState => turnState) => unit

