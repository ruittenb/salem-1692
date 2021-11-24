
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

@decco type player = string
@decco type players = array<player>

let playersFromJson = (playerArrayJson: Js.Json.t): option<array<string>> => {
    playerArrayJson
        ->Js.Json.decodeArray
        ->Belt.Option.map(playerJsonArray => {
            playerJsonArray->Js.Array2.map(playerJson => {
                playerJson->Js.Json.decodeString
            })
                ->Belt.Array.keepMap(x => x)
        })
}

type nrWitches =
    | One
    | More

let nrWitchesToJs = (n: nrWitches): string => switch n {
    | One  => "One"
    | More => "More"
}

let nrWitchesFromJs = (n: string): Belt.Result.t<nrWitches, string> => switch n {
    | "One"  => Ok(One)
    | "More" => Ok(More)
    | _      => Error("Unknown number of witches")
}

/** **********************************************************************
 * Event Types
 */

type clickHandler  = ReactEvent.Mouse.t => unit
type mediaHandler  = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t  => unit
type blurHandler   = ReactEvent.Focus.t => unit

/** **********************************************************************
 * Firebase Types (some of these are defined in FirebaseAdapter.res)
 */

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

@deriving(jsConverter)
@decco type phase = [
    | #DaytimeWaiting
    | #NightWaiting
    | #NightChoiceWitches
    | #NightConfirmWitches
    | #NightChoiceConstable
    | #NightConfirmConstable
]

@deriving(jsConverter)
@decco type decision = [
    | #Yes
    | #No
    | #Undecided
]

type dbObservable =
    | GameSubject
    | MasterPhaseSubject
    | MasterPlayersSubject
    | MasterSeatingSubject
    | MasterNumberWitchesSubject
    | ChooseWitchesSubject
    | ChooseConstableSubject
    | ConfirmWitchesSubject
    | ConfirmConstableSubject

type dbRecord = {
    masterGameId: GameTypeCodec.gameId,
    masterPhase: phase,
    masterPlayers: array<player>,
    masterSeating: string,
    masterNumberWitches: string,
    slaveChoiceWitches: player,
    slaveChoiceConstable: player,
    slaveConfirmWitches: decision,
    slaveConfirmConstable: decision,
    updatedAt: string,
}

/** **********************************************************************
 * Game Types
 */

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
    nrWitches: nrWitches,
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
    | SetupMaster
    | SetupSlave
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

