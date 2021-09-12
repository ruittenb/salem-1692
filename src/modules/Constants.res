
/** ****************************************************************************
 * Constants
 */

let siteUrl = "https://ruittenb.github.io/salem-1692/dist/"

let localStoragePrefix = "salem1692"
let localStorageGameStateKey = ".gameState"

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
