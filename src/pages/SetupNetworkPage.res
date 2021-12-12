/** ****************************************************************************
 * SetupNetworkPage
 */

open Types

@get external getValue: (Dom.element) => string = "value"

let pm = "[SetupNetworkPage:Master] "
let ps = "[SetupNetworkPage:Slave] "

let inputElementId = "formGameId"

/** ****************************************************************************
 * Master functions
 */
let startHosting = (setDbConnectionStatus, gameState, setGameState) => {
    Utils.logDebug(pm ++ "Starting hosting")
    setDbConnectionStatus(_prev => Connecting)
    FirebaseClient.connect()
        ->Promise.then(dbConnection => {
            let newGameId = if gameState.gameType === Master {
                // We already are Master. This happens when the Master state
                // was read from localstorage. Reuse the old gameId.
                gameState.gameId
            } else {
                GameId.getGameId()
            }
            let newGameState = {
                ...gameState,
                gameType: Master,
                gameId: newGameId
            }
            FirebaseClient.createGame(dbConnection, newGameState)
                ->Promise.then(() => {
                    setGameState(_prev => newGameState)
                    setDbConnectionStatus(_prev => Connected(dbConnection))
                    Promise.resolve()
                })
        })
        ->Promise.catch(error => {
            setDbConnectionStatus(_prev => NotConnected)
            error->Utils.getExceptionMessage->Utils.logError
            Promise.resolve()
        })
        ->ignore
}

let stopHosting = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    Utils.logDebug(pm ++ "Stopping hosting")
    Utils.ifConnected(dbConnectionStatus, (dbConnection) => {
        FirebaseClient.deleteGame(dbConnection, gameState.gameId)
        FirebaseClient.disconnect(dbConnection)
    })
    setDbConnectionStatus(_prev => NotConnected)
    setGameState((prevGameState) => {
        ...prevGameState,
        gameType: StandAlone
    })
}

/** ****************************************************************************
 * Slave functions
 */

let joinGame = (setDbConnectionStatus, setGameState, newGameId, callback) => {
    Utils.logDebug(ps ++ "Joining game " ++ newGameId)
    setDbConnectionStatus(_prev => Connecting)
    FirebaseClient.connect()
        ->Promise.then(dbConnection => {
            setGameState(prevGameState => {
                ...prevGameState,
                gameType: Slave(newGameId)
            })
            setDbConnectionStatus(_prev => Connected(dbConnection))
            FirebaseClient.joinGame(dbConnection, newGameId)
            callback()
            Promise.resolve()
        })
        ->Promise.catch(error => {
            setGameState(prevGameState => {
                ...prevGameState,
                gameType: StandAlone
            })
            setDbConnectionStatus(_prev => NotConnected)
            error->Utils.getExceptionMessage->Utils.logError
            Promise.resolve()
        })
        ->ignore
}

let leaveGame = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
        Utils.logDebug(ps ++ "Leaving game " ++ gameId)
        FirebaseClient.leaveGame(dbConnection, gameId)
        FirebaseClient.disconnect(dbConnection)
        setDbConnectionStatus(_prev => NotConnected)
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: StandAlone
        })
    })
}

let tryPlayAsSlave = (goToPage, dbConnectionStatus, setDbConnectionStatus, gameState, setGameState, setSlaveGameIdValidity) => {
    let newGameId = Utils.safeQuerySelector(inputElementId)
        ->Belt.Result.mapWithDefault("", getValue)
    if (!GameId.isValid(newGameId)) {
        // Code is not valid
        Utils.logDebug(ps ++ "Code " ++ newGameId ++ " is not valid")
        leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
        setSlaveGameIdValidity(_prev => InputShownAndInvalid)
    } else {
        // Code is valid
        Utils.logDebug(ps ++ "Code " ++ newGameId ++ " is valid")
        setSlaveGameIdValidity(_prev => InputShown)
        // We should always disconnect so that we won't have multiple listeners
        leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
        joinGame(setDbConnectionStatus, setGameState, newGameId, () =>
            goToPage(_prev => DaytimeWaiting)
        )
    }
}

/** ****************************************************************************
 * Page functions
 */

let getModusOperandi = (
    t,
    goToPage,
    gameState,
    setGameState,
    dbConnectionStatus,
    setDbConnectionStatus,
    slaveGameIdValidity,
    setSlaveGameIdValidity,
) => switch (gameState.gameType, dbConnectionStatus, slaveGameIdValidity) {
    | (StandAlone, _, InputHidden) =>
                        <>
                            <h2> {React.string(t("Be a Host"))} </h2>
                            <p> {React.string(t("You can host a game so that players can join from another smartphone."))} </p>
                            <Spacer />
                            <Button
                                label={t("Start Hosting")}
                                className="condensed-fr"
                                onClick={ _event => startHosting(
                                    setDbConnectionStatus, gameState, setGameState,
                                ) }
                            />
                            <Rule />
                            <h2> {React.string(t("Be a Guest"))} </h2>
                            <p> {React.string(t("You can join a game running on another smartphone."))} </p>
                            <Spacer />
                            <Button
                                label={t("Join Game")}
                                onClick={ _event => setSlaveGameIdValidity(_prev => InputShown) }
                            />
                        </>
    | (Master, NotConnected, _) =>
                        <>
                            // Should never happen: we should be connected before we set the game type to Master
                            <Spacer />
                            <Button
                                label={t("Start Hosting")}
                                className="condensed-fr"
                                onClick={ _event => startHosting(
                                    setDbConnectionStatus, gameState, setGameState,
                                ) }
                            />
                        </>
    | (Master, Connecting, _) =>
                        <>
                            <Spacer />
                            {React.string(t("Connecting..."))}
                            // TODO add abort connecting button
                        </>
    | (Master, Connected(_), _) =>
                        <>
                            <h2> {React.string(t("Be a Host"))} </h2>
                            <p>
                                {React.string(t("You are currently hosting a game.") ++ " ")}
                                {React.string(t(
                                    // needs backticks for unicode arrow
                                    `Take the other smartphone and look in the app under Multi-Telephone → Be a Guest. ` ++
                                    "Then enter the following game code there."
                                ))}
                            </p>
                            <Spacer />
                            <div className="id-input"> {React.string(gameState.gameId)} </div>
                            <Spacer />
                            <QR value=gameState.gameId />
                            <Spacer />
                            <Spacer />
                            <Button
                                label={t("Play Game")}
                                className="icon-right icon-forw condensed-nl"
                                onClick=(_event => goToPage(_prev => Daytime)) // TODO
                            />
                            <Button
                                label={t("Stop Hosting")}
                                className="condensed-nl"
                                onClick={ _event => stopHosting(
                                    dbConnectionStatus, setDbConnectionStatus,
                                    gameState, setGameState,
                                ) }
                            />
                            <Rule />
                            <h2> {React.string(t("Be a Guest"))} </h2>
                            <p> {React.string(t("If you want to join a running game, you must stop hosting first."))} </p>
                            <Spacer />
                        </>
    | (StandAlone, dbConnectionStatus, slaveGameIdValidity)
    | (Slave(_), dbConnectionStatus, slaveGameIdValidity) =>
                        <>
                            <h2> {React.string(t("Be a Guest"))} </h2>
                            <p>
                                {React.string(t(
                                    // needs backticks for unicode arrow
                                    `Take the other smartphone and look in the app under Multi-Telephone → Be a Host. ` ++
                                    "Then enter the game code here."
                                ))}
                            </p>
                            <Spacer />
                            <input
                                type_="text" id={inputElementId} className="id-input"
                                maxLength=15
                                placeholder="x00-x00-x00-x00"
                                onChange={(_event) => {
                                    leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
                                    setSlaveGameIdValidity(_prev => InputShownAndInvalid)
                                }}
                            />
                            <Capture size=150 callback={(_gameId) => ()} />
                            <p>
                                {
                                    let slaveConnectionStatus = switch (dbConnectionStatus) {
                                        | NotConnected if slaveGameIdValidity === InputShownAndInvalid => "Invalid code"
                                        | NotConnected                => "Not connected"
                                        | Connecting                  => "Connecting..."
                                        | Connected(_)                => "Connected."
                                    }
                                    React.string(t(slaveConnectionStatus))
                                }
                            </p>
                            <Spacer />
                            // Back/Forward buttons
                            <Button label={t("Next")} className="icon-right icon-forw condensed-nl" onClick={(_event) => tryPlayAsSlave(
                                goToPage,
                                dbConnectionStatus, setDbConnectionStatus,
                                gameState, setGameState,
                                setSlaveGameIdValidity,
                            )} />
                            <Button label={t("Back")} className="icon-left icon-back" onClick={(_event) => {
                                leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
                                goToPage(_prev => SetupNetwork)
                            }} />
                            <Rule />
                            <h2> {React.string(t("Be a Host"))} </h2>
                            <p> {React.string(t("If you want to host a game so that others can join, you should leave this screen first."))} </p>
                        </>
}

/** ****************************************************************************
 * React Component
 */
@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {
    let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (slaveGameIdValidity, setSlaveGameIdValidity) = React.useState(_ => InputHidden)

    let modusOperandi = getModusOperandi(
        t,
        goToPage,
        gameState, setGameState,
        dbConnectionStatus, setDbConnectionStatus,
        slaveGameIdValidity, setSlaveGameIdValidity,
    )

    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <BackFloatingButton onClick={(_event) => {
            leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
            goToPage(_prev => Title)
        }} />
        <GearFloatingButton goToPage returnPage />
        <h1 className="condensed-es" >
            {React.string(t("Multi-Telephone"))}
        </h1>
        {modusOperandi}
    </div>
}

