/* *****************************************************************************
 * Utils
 */

open Types

@get external getTagName: Dom.element => string = "tagName"

let identity = (arg: 'a): 'a => arg

/**
 * Log a message to console with error formatting
 */
let logError = (msg: string): unit => {
  Js.log2("%cError: " ++ msg, Constants.consoleErrorFormatting)
}

/**
 * Log a message to console only if debug flag is set
 */
let logDebug = (msg: string): unit => {
  if Constants.debug {
    Js.log(msg)
  }
}

/**
 * Log a value to console. Then return it. For incorporating into pipelines.
 */
let logDebugAny = (x: 'a, msg: string): 'a => {
  Js.log2(msg, x)
  x
}

/**
 * Log a message to console with highlighting
 */
let logDebugStyled = (msg: string, style: string): unit => {
  if Constants.debug {
    Js.log2("%c" ++ msg, style)
  }
}

/**
 * Log a message to console with highlighting
 */
let logDebugBlue = (msg: string): unit => {
  if Constants.debug {
    Js.log2("%c" ++ msg, "color: blue")
  }
}

/**
 * Log a message to console with highlighting
 */
let logDebugGreen = (msg: string): unit => {
  if Constants.debug {
    Js.log2("%c" ++ msg, "font-weight: bold; color: green")
  }
}

/**
 * Extract message from exception
 */
let getExceptionMessage = (error: exn): string => {
  error
  ->Js.Exn.asJsExn
  ->Belt.Option.flatMap(Js.Exn.message)
  ->Belt.Option.getWithDefault("An unknown error occurred")
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
  let index = Js.Math.random_int(0, set->Belt.Array.length)
  set->Belt.Array.get(index)->Belt.Option.getWithDefault(default)
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
let replaceWith = (_first: 'a, second: 'b): 'b => {
  second
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

/*
 * Convert [ Some(3), Some(6), None, Some(-1), None ] into [ 3, 6, -1 ]:
 * use Belt.Array.keepMap(identity)
 *
 *
 * Js.Option.andThen(), but data-first:
 * use Belt.Option.flatMap()
 *
 *
 * Js.Option.map(), but data-first:
 * use Belt.Option.map()
 */
