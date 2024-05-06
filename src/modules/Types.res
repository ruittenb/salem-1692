/* *****************************************************************************
 * Types
 */

/* ************************************************************************
 * Event Types (convenience)
 */

type clickHandler = ReactEvent.Mouse.t => unit
type mediaHandler = ReactEvent.Media.t => unit
type changeHandler = ReactEvent.Form.t => unit
type blurHandler = ReactEvent.Focus.t => unit

/* ************************************************************************
 * Game Types
 */

type permissionState =
  | Granted
  | Denied
  | Prompt
  | Dismissed
  | Unsupported

type evenOdd =
  | Even
  | Odd

type direction =
  | North
  | South
  | West
  | East
  | Nowhere

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

let playersFromJson = (playerArrayJson: Js.Json.t): option<array<string>> => {
  playerArrayJson
  ->Js.Json.decodeArray
  ->Belt.Option.map(playerJsonArray => {
    playerJsonArray->Js.Array2.map(Js.Json.decodeString)->Belt.Array.keepMap(x => x)
  })
}

@spice
type gameState = {
  gameType: GameTypeCodec.t,
  language: LanguageCodec.t,
  players: array<PlayerCodec.t>,
  seating: SeatingCodec.t,
  hasGhostPlayers: bool,
  doPlayEffects: bool,
  doPlaySpeech: bool,
  doPlayMusic: bool,
  doKeepActive: bool,
  backgroundMusic: array<string>,
}
type gameStateSetter = (gameState => gameState) => unit

type turnState = {
  nrWitches: NumerusCodec.t,
  nightType: NightTypeCodec.t,
  choiceWitches: PlayerCodec.t,
  choiceConstable: PlayerCodec.t,
}
type turnStateSetter = (turnState => turnState) => unit

type page =
  | Title
  | Setup
  | SetupLanguage
  | SetupMusic
  | SetupPlayers
  | SetupNetwork
  | SetupNetworkNoGame
  | Credits
  // Master
  | Daytime
  | NightDawnOneWitch
  | NightDawnMoreWitches
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

type routerSetter = (page => page) => unit

type audioSpeech =
  | TownGoToSleep
  | TownStillAsleep
  | WitchWakeUp
  | WitchesWakeUp
  | WitchDecideCat
  | WitchesDecideCat
  | WitchesDecideMurder
  | WitchGoToSleep
  | WitchesGoToSleep
  | ConstableWakeUp
  | ConstableDecideAny
  | ConstableDecideOther
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

type rec getConditionalStep = gameState => scenarioStep

and /* type */ scenarioStep =
  | PlaySpeech(audioSpeech)
  | PlayEffect(audioEffect)
  | PlayRandomEffect(array<audioEffect>)
  | Pause(float)
  | ConditionalStep(getConditionalStep)
  | ChooseWitches
  | ConfirmWitches
  | ChooseConstable
  | ConfirmConstable

type scenario = array<scenarioStep>

type addressed =
  | Witch
  | Witches
  | Constable

/* ************************************************************************
 * Firebase Types
 */

// These are defined in FirebaseAdapter.res through bindings
type dbApp
type dbDatabase
type dbReference
type dbSnapshot
type dbAnalytics

type dbConnection = {
  app: dbApp,
  db: dbDatabase,
}

type dbConnectionStatus =
  | NotConnected
  | ConnectingAsMaster
  | ConnectingAsSlave
  | Connected(dbConnection)

type dbConnectionSetter = (dbConnectionStatus => dbConnectionStatus) => unit

type dbConfig = {
  apiKey: string,
  authDomain: string,
  databaseURL: string,
  projectId: string,
  storageBucket: string,
  messagingSenderId: string,
  appId: string,
  measurementId: string,
}

type dbObservable =
  | GameSubject
  | MasterPhaseSubject
  | MasterPlayersSubject
  | MasterSeatingSubject
  | MasterNumberWitchesSubject
  | MasterNightTypeSubject
  | MasterHasGhostPlayersSubject
  | ChoiceWitchesSubject
  | ChoiceConstableSubject
  | ConfirmWitchesSubject
  | ConfirmConstableSubject

@spice
type dbRecord = {
  masterGameId: GameTypeCodec.gameId,
  masterLanguage: LanguageCodec.t,
  masterPhase: PhaseCodec.t,
  masterPlayers: array<PlayerCodec.t>,
  masterSeating: SeatingCodec.t,
  masterNumberWitches: NumerusCodec.t,
  masterNightType: NightTypeCodec.t,
  masterHasGhostPlayers: bool,
  slaveChoiceWitches: PlayerCodec.t,
  slaveChoiceConstable: PlayerCodec.t,
  slaveConfirmWitches: ConfirmationCodec.t,
  slaveConfirmConstable: ConfirmationCodec.t,
  updatedAt: string,
}
