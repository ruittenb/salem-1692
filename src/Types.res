
/** ****************************************************************************
 * Types
 */

type clickHandler = ReactEvent.Mouse.t => unit
type mediaHandler = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t => unit

type either<'t, 'v> =
    | Left('t)
    | Right('v)

type language =
    | NL_NL
    | EN_US
    | ES_ES

type player = string
type players = array<player>

type evenOdd =
    | Even
    | Odd

/**
 * How are the players seated around the table?
 *
 *           even nr. players          odd nr. players
 *        ----------------------    ----------------------
 *        TwoAtHead    OneAtHead    OneAtHead    TwoAtHead
 *        ---------    ---------    ---------    ---------
 *          o   o          o            o          o   o
 *          o   o        o   o        o   o        o   o
 *          o   o        o   o        o   o        o   o
 *          o   o          o          o   o          o
 */
type seatingLayout =
    | OneAtHead
    | TwoAtHead

type gameState = {
    players: players,
    seatingLayout: seatingLayout,
    doPlayEffects: bool,
    doPlaySpeech: bool,
}
type gameStateSetter = (gameState => gameState) => unit

type turnState = {
    nrWitches: int,
    hasConstable: bool,
    choiceWitches: string,
    choiceConstable: string,
}
type turnStateSetter = (turnState => turnState) => unit

type page =
    | Title
    | Setup
    | SetupLanguage
    | SetupPlayers
    | SetupPlayersForGame
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

