/* *****************************************************************************
 * GameId
 */

let lowercaseA = 97
let lowercaseZ = 122

let getChar = (): string => {
  Math.Int.random(lowercaseA, lowercaseZ + 1)->String.fromCharCode
}

let getDigit = (): string => {
  Math.Int.random(0, 10)->Int.toString
}

let getGameIdUnit = (): string => {
  getChar() ++ getDigit() ++ getDigit()
}

let generateGameId = (): string => {
  [getGameIdUnit(), getGameIdUnit(), getGameIdUnit(), getGameIdUnit()]->Array.join("-")
}

let isValid = (id: string): bool => {
  RegExp.fromString("^([a-z][0-9][0-9]-){3}[a-z][0-9][0-9]$")->RegExp.test(id)
}
