
/** ****************************************************************************
 * Types
 */

type evenOdd =
    | Even
    | Odd

type rotation =
    | RotNone
    | RotOneQuarter
    | RotOneHalf
    | RotThreeQuarters

/** **********************************************************************
 * Event Types
 */

type clickHandler  = ReactEvent.Mouse.t => unit
type mediaHandler  = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t  => unit
type blurHandler   = ReactEvent.Focus.t => unit

/** **********************************************************************
 * Firebase Types (some of these are defined in Firebase.res)
 */

module Firebase = {

    type app
    type database
    type reference
    type snapshot
    type data

    type connection = {
        app: app,
        db: database
    }

    type config = {
        apiKey            : string,
        authDomain        : string,
        databaseURL       : string,
        projectId         : string,
        storageBucket     : string,
        messagingSenderId : string,
        appId             : string,
    }
}

/** **********************************************************************
 * Game Types
 */

@decco type player = string
@decco type players = array<player>

@decco type gameState = {
    gameType: GameTypeCodec.t,
    gameId: GameTypeCodec.gameId,
    language: LanguageCodec.t,
    players: players,
    seating: SeatingCodec.t,
    doPlayEffects: bool,
    doPlaySpeech: bool,
    backgroundMusic: array<string>,
}
type gameStateSetter = (gameState => gameState) => unit

type nrWitches =
    | One
    | More

type turnState = {
    nrWitches: nrWitches,
    choiceWitches: option<string>,
    choiceConstable: option<string>,
}
type turnStateSetter = (turnState => turnState) => unit

type page =
    | Title
    | Setup
    | SetupLanguage
    | SetupMusic
    | SetupPlayers
    | SetupPlayersForGame
    | SetupMaster
    | SetupSlave
    | Credits
    | Daytime
    | FirstNightOneWitch
    | FirstNightMoreWitches
    | OtherNightWithConstable
    | OtherNightNoConstable
    | DaytimeConfess
    | DaytimeReveal
    | DaytimeRevealNoConfess
    | Close

type navigationSetter = (option<page> => option<page>) => unit

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

