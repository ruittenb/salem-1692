
/** ****************************************************************************
 * GameId
 */

let lowercaseA = 97
let lowercaseZ = 123

let getChar = (): string => {
    Js.Math.random_int(lowercaseA, lowercaseZ + 1)->Js.String2.fromCharCode
}

let getDigit = (): string => {
    Js.Math.random_int(0, 10)->Js.Int.toString
}

let getGameIdUnit = (): string => {
    getChar() ++ getDigit() ++ getDigit()
}

let getGameId = (): string => {
    [ getGameIdUnit(), getGameIdUnit(), getGameIdUnit(), getGameIdUnit() ]->Js.Array2.joinWith("-")
}

