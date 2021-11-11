
/** ****************************************************************************
 * Utils
 */

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
    if (Constants.debug) {
        Js.log(msg)
    }
}

/**
 * Log a message to console with highlighting
 */
let logDebugStyled = (msg: string, style: string): unit => {
    if (Constants.debug) {
        Js.log2("%c" ++ msg, style)
    }
}

/**
 * Log a message to console with highlighting
 */
let logDebugRed = (msg: string): unit => {
    if (Constants.debug) {
        Js.log2("%c" ++ msg, "color: red")
    }
}

/**
 * Log a message to console with highlighting
 */
let logDebugGreen = (msg: string): unit => {
    if (Constants.debug) {
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
    set ->Belt.Array.get(index)
        ->Belt.Option.getWithDefault(default)
}

/**
 * Calls a function that may throw an exception.
 * The result is converted into an option.
 */
let safeExec = (
    functionThatMayThrow: () => 'a
): option<'a> => {
    try {
        functionThatMayThrow()->Some
    } catch {
        | error =>
            error
                ->getExceptionMessage
                ->logError
            None
    }
}

/**
 * Tries to find a DOM node in the document.  Returns a Result.
 */
let safeQuerySelector = (
    elementId: string
): Belt.Result.t<Dom.element, string> => {
    try {
        switch (ReactDOM.querySelector("#" ++ elementId)) {
            | Some(element) => Ok(element)
            | None          => Error("Cannot find DOM element with id '" ++ elementId ++ "'")
        }
    } catch {
        | error =>
            error
                ->getExceptionMessage
                ->Error
    }
}

/**
 * Replaces a value with another one.
 *
 * Example:
 * fn1()->replaceWith(React.null)
 */
let replaceWith = (
    _first: 'a,
    second: 'b
): 'b => {
    second
}

let resultForEach = (
    result: Belt.Result.t<'ok, 'err>,
    fn: ('ok) => unit
) => {
    switch result {
        | Ok(value) => fn(value)
        | Error(_)  => ()
    }
}

/**
 * Call function if connection state reflects that we're connected to firebase
 */
let ifConnected = (
    dbConnectionStatus: Types.FbDb.dbConnectionStatus,
    func: (Types.FbDb.dbConnection) => unit
) => {
    switch dbConnectionStatus {
        | NotConnected            => ()
        | Connecting              => ()
        | Connected(dbConnection) => func(dbConnection)
    }
}

/**
 * Call function if game state reflects that we're Master
 */
let ifMaster = (
    gameType: GameTypeCodec.t,
    func: () => unit
) => {
    switch gameType {
        | StandAlone => ()
        | Master     => func()
        | Slave(_)   => ()
    }
}

/**
 * Combine two functions above
 */
let ifMasterAndConnected = (
    dbConnectionStatus: Types.FbDb.dbConnectionStatus,
    gameType: GameTypeCodec.t,
    func: (Types.FbDb.dbConnection) => unit
) => {
    ifMaster(gameType, () => {
        ifConnected(dbConnectionStatus, (dbConnection) => {
            func(dbConnection)
        })
    })
}

/**
 * Call function if game state reflects that we're Slave
 */
let ifSlave = (
    gameType: GameTypeCodec.t,
    func: (GameTypeCodec.gameId) => unit
) => {
    switch gameType {
        | StandAlone    => ()
        | Master        => ()
        | Slave(gameId) => func(gameId)
    }
}

/**
 * Combine two functions above
 */
let ifSlaveAndConnected = (
    dbConnectionStatus: Types.FbDb.dbConnectionStatus,
    gameType: GameTypeCodec.t,
    func: (
        Types.FbDb.dbConnection,
        GameTypeCodec.gameId
    ) => unit
) => {
    ifSlave(gameType, (gameId) => {
        ifConnected(dbConnectionStatus, (dbConnection) => {
            func(dbConnection, gameId)
        })
    })
}


/**
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

