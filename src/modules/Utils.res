/* *****************************************************************************
 * Utils
 */

open Types

@get external getTagName: Dom.element => string = "tagName"

let identity = (arg: 'a): 'a => arg

/**
 * Log a message to console with highlighting
 */
let logStyled = (~bold, ~color, msg: string): unit => {
  let boldStyle = bold ? "font-weight: bold;" : ""
  Js.log2("%c" ++ msg, boldStyle ++ "color: " ++ color)
}

/**
 * Log a message to console only if debug flag is set
 */
let logDebug = (~bold=false, ~color="black", msg: string): unit => {
  if Constants.debug {
    logStyled(msg, ~color, ~bold)
  }
}

/**
 * Log a value to console. Then return it. For incorporating into pipelines.
 */
let logDebugPipe = (x: 'a, msg: string): 'a => {
  Js.log2(msg, x)
  x
}

/**
 * Log a message to console with error formatting
 */
let logError = (msg: string): unit => {
  logStyled("Error: " ++ msg, ~bold=true, ~color="red")
}

/**
 * Log a message to console with highlighting
 */
let logDebugBlue = (msg: string): unit => {
  logDebug(msg, ~bold=true, ~color="blue")
}

let logDebugGreen = (msg: string): unit => {
  logDebug(msg, ~bold=true, ~color="green")
}

let logDebugPurple = (msg: string): unit => {
  logDebug(msg, ~bold=true, ~color="purple")
}

/**
 * Extract message from exception
 */
let getExceptionMessage = (error: exn): string => {
  error
  ->Js.Exn.asJsExn
  ->Option.flatMap(x => Js.Exn.message(x))
  ->Option.getOr("An unknown error occurred")
}

/**
 * Catch an exception, log it, and ignore it
 */
let catchLogAndIgnore = (p, resolutionValue): unit => {
  Promise.catch(p, (error: exn) => {
    error->getExceptionMessage->logError
    Promise.resolve(resolutionValue)
  })->ignore
}

/**
 * Pick a random element from a set.
 */
let pickRandomElement = (set: array<'a>, default: 'a): 'a => {
  let index = Math.Int.random(0, set->Array.length)
  set->Array.get(index)->Option.getOr(default)
}

/**
 * Calls a function that may throw an exception.
 * The result is converted to an option.
 */
let safeExec = (functionThatMayThrow: unit => 'a): option<'a> => {
  try {
    functionThatMayThrow()->Some
  } catch {
  | error =>
    error->getExceptionMessage->logError
    None
  }
}

/**
 * Tries to find a DOM node in the document.  Returns a Result.
 */
let safeQuerySelector = (elementId: string): Belt.Result.t<Dom.element, string> => {
  try {
    switch ReactDOM.querySelector("#" ++ elementId) {
    | Some(element) => Ok(element)
    | None => Error("Cannot find DOM element with id '" ++ elementId ++ "'")
    }
  } catch {
  | error => error->getExceptionMessage->Error
  }
}

/**
 * Return the DOM node only if it is of a specific type.
 */
let ifTagName = (element: Dom.element, tagName: string): option<Dom.element> => {
  element->getTagName === tagName ? Some(element) : None
}

/**
 * Replaces a value with another one.
 *
 * Example:
 * fn1()->replaceWith(React.null)
 */
let replaceWith = (_first: 'a, second: 'b): 'b => second

/**
 * Produce a range of alternating integers between bounds
 */
let alternatingRange = (first: int, last: int) => {
  // e.g. first = 2, last = 7
  let numbers = Array.fromInitializer(~length=1 + last - first, x => x + first)
  // e.g. 2,3,4,5,6
  numbers->Array.filterWithIndex((_value, index) => Int.mod(index, 2) === 0)
  // e.g. 2,4,6
}

/**
 * Run a function on an Ok-value
 *
 * Example:
 * queryResult->resultForEach(value => process(value))
 */
let resultForEach = (result: Belt.Result.t<'ok, 'err>, fn: 'ok => unit) => {
  switch result {
  | Ok(value) => fn(value)
  | Error(_) => ()
  }
}

let resultToOption = (result: Belt.Result.t<'a, 'b>) => {
  switch result {
  | Ok(value) => Some(value)
  | Error(_) => None
  }
}

/**
 * Reduce a tuple of maybes to a maybe of a tuple.
 *
 * Example:
 *   (Some("string"), None)->optionTupleAnd
 *   (Some("first"), Some("second"))->optionTupleAnd
 */
let optionTupleAnd = (tupleOfMaybes: (option<'a>, option<'b>)): option<('a, 'b)> => {
  switch tupleOfMaybes {
  | (Some(a), Some(b)) => Some((a, b))
  | _ => None
  }
}

/*
 * Convert [ Some(3), Some(6), None, Some(-1), None ] into [ 3, 6, -1 ]:
 * use Array.keepSome
 */

/* ****************************************************************************
 * Firebase
 */

/**
 * Call function if connection state reflects that we're connected to firebase
 */
let ifConnected = (dbConnectionStatus: dbConnectionStatus, func: dbConnection => unit) => {
  switch dbConnectionStatus {
  | NotConnected => ()
  | ConnectingAsMaster => ()
  | ConnectingAsSlave => ()
  | Connected(dbConnection) => func(dbConnection)
  }
}

/**
 * Return true if connection state reflects that we're connected to firebase
 */
let isConnected = (dbConnectionStatus: dbConnectionStatus) => {
  switch dbConnectionStatus {
  | NotConnected
  | ConnectingAsMaster
  | ConnectingAsSlave => false
  | Connected(_) => true
  }
}

/**
 * Call function if game state reflects that we're Master
 */
let ifMaster = (gameType: GameTypeCodec.t, func: GameTypeCodec.gameId => unit) => {
  switch gameType {
  | StandAlone => ()
  | Master(gameId) => func(gameId)
  | Slave(_) => ()
  }
}

/**
 * Return gameId if game state reflects that we're Master
 */
let ifMasterGetGameId = (gameType: GameTypeCodec.t): string => {
  switch gameType {
  | StandAlone => ""
  | Master(gameId) => gameId
  | Slave(_) => ""
  }
}

/**
 * Convenience: combine ifMaster and ifConnected
 */
let ifMasterAndConnected = (
  dbConnectionStatus: dbConnectionStatus,
  gameType: GameTypeCodec.t,
  func: (dbConnection, GameTypeCodec.gameId) => unit,
) => {
  ifMaster(gameType, gameId => {
    ifConnected(dbConnectionStatus, dbConnection => {
      func(dbConnection, gameId)
    })
  })
}

/**
 * Call function if game state reflects that we're Slave
 */
let ifSlave = (gameType: GameTypeCodec.t, func: GameTypeCodec.gameId => unit) => {
  switch gameType {
  | StandAlone => ()
  | Master(_) => ()
  | Slave(gameId) => func(gameId)
  }
}

/**
 * Return gameId if game state reflects that we're Slave
 */
let ifSlaveGetGameId = (gameType: GameTypeCodec.t): string => {
  switch gameType {
  | StandAlone => ""
  | Master(_) => ""
  | Slave(gameId) => gameId
  }
}

/**
 * Combine two functions above
 */
let ifSlaveAndConnected = (
  dbConnectionStatus: dbConnectionStatus,
  gameType: GameTypeCodec.t,
  func: (dbConnection, GameTypeCodec.gameId) => unit,
) => {
  ifSlave(gameType, gameId => {
    ifConnected(dbConnectionStatus, dbConnection => {
      func(dbConnection, gameId)
    })
  })
}
