/* *****************************************************************************
 * GameId
 */

let lowercaseA = 97
let lowercaseZ = 122

let getChar = (): string => {
  Js.Math.random_int(lowercaseA, lowercaseZ + 1)->Js.String2.fromCharCode
}

let getDigit = (): string => {
  Js.Math.random_int(0, 10)->Js.Int.toString
}

let getGameIdUnit = (): string => {
  getChar() ++ getDigit() ++ getDigit()
}

let generateGameId = (): string => {
  [getGameIdUnit(), getGameIdUnit(), getGameIdUnit(), getGameIdUnit()]->Array.join("-")
}

let isValid = (id: string): bool => {
  Js.Re.fromString("^([a-z][0-9][0-9]-){3}[a-z][0-9][0-9]$")->Js.Re.test_(id)
}
