
/** ****************************************************************************
 * Constants
 */

// Debug mode can be enabled by changing the User-Agent string to contain the text
// "Salem/1692". See https://www.alphr.com/change-user-agent-string-google-chrome/

type navigator
@val external navigator: navigator = "navigator"
@get external userAgent: (navigator) => string = "userAgent"

let debug = navigator->userAgent->Js.String2.includes("Salem/1692")

// firebase, url, localstorage

let firebaseConfig: Types.FbDb.config = {
    apiKey            : "AIzaSyD_SDDuyHYXcj_xiw8V_BXmWb_X9TUWpK8",
    authDomain        : "salem-1692-moderator.firebaseapp.com",
    databaseURL       : "https://salem-1692-moderator-default-rtdb.europe-west1.firebasedatabase.app",
    projectId         : "salem-1692-moderator",
    storageBucket     : "salem-1692-moderator.appspot.com",
    messagingSenderId : "910714101001",
    appId             : "1:910714101001:web:1a9d4882f11f07376807d8",
}

let siteUrl = "https://ruittenb.github.io/salem-1692/dist/"

let localStoragePrefix = "salem1692"
let localStorageGameStateKey = ".gameState"

// game parameters

let consoleErrorFormatting = "color: red; font-weight: bold"

let backgroundVolume = 0.1

// Stripped of .mp3 extension
let musicTracks = [
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

let defaultSelectedMusicTracks = [
    "Myst on the Moor",
    "Some Amount of Evil",
]
