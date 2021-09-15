
/** ****************************************************************************
 * Types
 */

type clickHandler  = ReactEvent.Mouse.t => unit
type mediaHandler  = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t  => unit
type blurHandler   = ReactEvent.Focus.t => unit

type evenOdd =
    | Even
    | Odd

type rotation =
    | RotNone
    | RotOneQuarter
    | RotOneHalf
    | RotThreeQuarters

type nrWitches =
    | One
    | More

@decco type player = string
@decco type players = array<player>

@decco type gameState = {
    language: LanguageCodec.t,
    players: players,
    seating: SeatingCodec.t,
    doPlayEffects: bool,
    doPlaySpeech: bool,
    backgroundMusic: array<string>,
}
type gameStateSetter = (gameState => gameState) => unit

type turnState = {
    nrWitches: nrWitches,
    choiceWitches: option<string>,
    choiceConstable: option<string>,
}
type turnStateSetter = (turnState => turnState) => unit

type rec page =
    | Title
    | Setup(page)
    | SetupLanguage(page)
    | SetupMusic(page)
    | SetupPlayers(page)
    | SetupPlayersForGame(page)
    | Credits(page)
    | Daytime
    | FirstNightOneWitch
    | FirstNightMoreWitches
    | OtherNightWithConstable
    | OtherNightNoConstable
    | DaytimeConfess
    | DaytimeReveal
    | DaytimeRevealNoConfess
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
    | CatMeowing
    | ChurchBell
    | Crickets
    | DogBarking
    | Footsteps
    | Lark
    | Rooster
    | Silence1s
    | Silence2s
    | Thunderstrike

type audioMusic = string

type audioType =
    | Speech(audioSpeech)
    | Effect(audioEffect)
    | Music(audioMusic)

type scenarioStep =
    | PlaySpeech(audioSpeech)
    | PlayEffect(audioEffect)
    | PlayRandomEffect(array<audioEffect>)
    | Pause(float)
    | ChooseWitches
    | ConfirmWitches
    | ChooseConstable
    | ConfirmConstable

type scenario = array<scenarioStep>

type addressed =
    | Witch
    | Witches
    | Constable

