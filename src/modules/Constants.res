/* *****************************************************************************
 * Constants
 */

open Types

type document
type navigator
@val external window: Dom.window = "window"
@val external document: document = "document"
@val external navigator: navigator = "navigator"
@get external userAgent: navigator => string = "userAgent"
@get external language: navigator => string = "language"

@get external visibilityState: document => string = "visibilityState"
@send external addEventListener: (document, string, unit => unit) => unit = "addEventListener"
@send external removeEventListener: (document, string, unit => unit) => unit = "removeEventListener"

// Enable debug mode when the User-Agent string contains the text "Salem/1692".
let debug = navigator->userAgent->Js.String2.includes("Salem/1692")

// firebase, url, localstorage

let firebaseConfig: dbConfig = {
  apiKey: "AIzaSyBnFx8hLeg1ufuuLmtp_WEI0XfxxwCBh1w",
  authDomain: "salem-1692-moderator-new.firebaseapp.com",
  databaseURL: "https://salem-1692-moderator-new-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "salem-1692-moderator-new",
  storageBucket: "salem-1692-moderator-new.appspot.com",
  messagingSenderId: "146234537609",
  appId: "1:146234537609:web:f3808996d1f9066ea7b858",
  measurementId: "G-5Y56FM31Q6",
}

let siteUrl = "https://ruittenb.github.io/salem-1692/"
let codeUrl = "https://github.com/ruittenb/salem-1692/"

let localStoragePrefix = "salem1692"
let localStorageGameStateKey = ".gameState"

// game parameters

let backgroundVolume = 0.1

// Stripped of .mp3 extension
let musicTracks =
  [
    "Agnus Dei X",
    "Crusade",
    "Danse Macabre",
    "Dark Times",
    "Darkling",
    "Eternal Terminal",
    "Hitman",
    "Moonlight Hall",
    "Myst on the Moor",
    "Nightmare Machine",
    "Not As It Seems",
    "Schmetterling",
    "Serpentine Trek",
    "Sneaky Snitch",
    "Some Amount of Evil",
  ]->Js.Array2.sortInPlace

let defaultSelectedMusicTracks = ["Myst on the Moor", "Some Amount of Evil"]
let defaultPlayers: array<PlayerCodec.t> = [
  Player("Ambrosia"),
  Player("Bellatrix"),
  Player("Cassandra"),
  Player("Drizella"),
]

// Initialization values

let initialGameState = {
  gameType: StandAlone,
  language: #en_US,
  players: defaultPlayers,
  seating: #OneAtTop,
  hasGhostPlayers: false,
  doPlayEffects: true,
  doPlaySpeech: true,
  doPlayMusic: true,
  doKeepActive: true,
  backgroundMusic: defaultSelectedMusicTracks,
}

let initialTurnState: turnState = {
  nrWitches: One,
  nightType: Dawn,
  choiceWitches: PlayerCodec.Undecided,
  choiceConstable: PlayerCodec.Undecided,
}
