/** ****************************************************************************
 * Types
 */

/** **********************************************************************
 * Event Types (convenience)
 */

type clickHandler  = ReactEvent.Mouse.t => unit
type mediaHandler  = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t  => unit
type blurHandler   = ReactEvent.Focus.t => unit

/** **********************************************************************
 * Game Types
 */

type evenOdd =
    | Even
    | Odd

type rotation =
    | RotNone
    | RotOneQuarter
    | RotOneHalf
    | RotThreeQuarters

type slaveCodeValidity =
    | SlaveInputHidden
    | SlaveInputShown // validity unspecified
    | SlaveInputShownAndInvalid
    | SlaveInputShownAndAbsent

@decco type player = string
@decco type players = array<player>

let playersFromJson = (playerArrayJson: Js.Json.t): option<array<string>> => {
    playerArrayJson
        ->Js.Json.decodeArray
        ->Belt.Option.map(playerJsonArray => {
            playerJsonArray
                ->Js.Array2.map(Js.Json.decodeString)
                ->Belt.Array.keepMap(x => x)
        })
}

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

type turnState = {
    nrWitches: NumerusCodec.t,
    choiceWitches: option<player>,
    choiceConstable: option<player>,
}
type turnStateSetter = (turnState => turnState) => unit

type page =
    | Title
    | Setup
    | SetupLanguage
    | SetupMusic
    | SetupPlayers
    | SetupPlayersForGame
    | SetupNetwork
    | SetupNetworkNoGame
    | Credits
    // Master
    | Daytime
    | NightFirstOneWitch
    | NightFirstMoreWitches
    | NightOtherWithConstable
    | NightOtherNoConstable
    // Slave
    | DaytimeWaiting
    | NightWaiting
    | NightChoiceWitches
    | NightConfirmWitches
    | NightChoiceConstable
    | NightConfirmConstable
    // Master
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

/** **********************************************************************
 * Firebase Types
 */

// These are defined in FirebaseAdapter.res through bindings
type dbApp
type dbDatabase
type dbReference
type dbSnapshot

type dbConnection = {
    app: dbApp,
    db: dbDatabase
}

type dbConnectionStatus =
    | NotConnected
    | Connecting
    | Connected(dbConnection)

type dbConnectionSetter = (dbConnectionStatus => dbConnectionStatus) => unit

type dbConfig = {
    apiKey            : string,
    authDomain        : string,
    databaseURL       : string,
    projectId         : string,
    storageBucket     : string,
    messagingSenderId : string,
    appId             : string,
}

type dbObservable =
    | GameSubject
    | MasterPhaseSubject
    | MasterPlayersSubject
    | MasterSeatingSubject
    | MasterNumberWitchesSubject
    | ChoiceWitchesSubject
    | ChoiceConstableSubject
    | ConfirmWitchesSubject
    | ConfirmConstableSubject

@decco type dbRecord = {
    masterGameId: GameTypeCodec.gameId,
    masterPhase: PhaseCodec.t,
    masterPlayers: array<player>,
    masterSeating: SeatingCodec.t,
    masterNumberWitches: NumerusCodec.t,
    slaveChoiceWitches: player,
    slaveChoiceConstable: player,
    slaveConfirmWitches: DecisionCodec.t,
    slaveConfirmConstable: DecisionCodec.t,
    updatedAt: string,
}

