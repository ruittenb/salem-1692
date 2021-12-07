/** ****************************************************************************
 * SetupSlavePage
 */

open Types

@get external getValue: (Dom.element) => string = "value"

let p = "[SetupSlavePage] "

let inputElementId = "formGameId"

// If we're a Master, then stop hosting the current game.
let stopHosting = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection) => {
        Utils.logDebug(p ++ "Stopping hosted game " ++ gameState.gameId)
        FirebaseClient.deleteGame(dbConnection, gameState.gameId)
        FirebaseClient.disconnect(dbConnection)
        setDbConnectionStatus(_prev => NotConnected)
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: StandAlone
        })
    })
}

// If we're a Slave, then leave the current game.
let leaveGame = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
        Utils.logDebug(p ++ "Leaving game " ++ gameId)
        FirebaseClient.leaveGame(dbConnection, gameId)
        FirebaseClient.disconnect(dbConnection)
        setDbConnectionStatus(_prev => NotConnected)
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: StandAlone
        })
    })
}

let connectAndJoin = (setDbConnectionStatus, setGameState, newGameId, callback) => {
    Utils.logDebug(p ++ "Joining game " ++ newGameId)
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

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (invalidCode, setInvalidCode) = React.useState(_ => false)

    let placeholder = "x00-x00-x00-x00"
    let defaultValue = switch gameState.gameType {
        | StandAlone    => ""
        | Master        => ""
        | Slave(gameId) => gameId
    }

    let onChange = (_event) => {
        leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
        setInvalidCode(_prev => false)
    }

    let onBack = (_event) => {
        leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
        goToPage(_prev => SetupNetwork)
    }

    let onForward = (_event) => {
        let newGameId = Utils.safeQuerySelector(inputElementId)
            ->Belt.Result.mapWithDefault("", getValue)
        if (!GameId.isValid(newGameId)) {
            // Code is not valid
            Utils.logDebug(p ++ "Code " ++ newGameId ++ " is not valid")
            leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
            setInvalidCode(_prev => true)
        } else {
            // Code is valid
            Utils.logDebug(p ++ "Code " ++ newGameId ++ " is valid")
            setInvalidCode(_prev => false)
            // We should always disconnect so that we won't have multiple listeners
            leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
            connectAndJoin(setDbConnectionStatus, setGameState, newGameId, () =>
                goToPage(_prev => DaytimeWaiting)
            )
        }
    }

    let connectionStatus = switch (dbConnectionStatus) {
        | NotConnected if invalidCode => <p> {React.string(t("Invalid code"))} </p>
        | NotConnected                => <p> {React.string(t("Not connected"))} </p>
        | Connecting                  => <p> {React.string(t("Connecting..."))} </p>
        | Connected(_)                => <p> {React.string(t("Connected."))} </p>
    }

    let modusOperandi = switch gameState.gameType {
        /* | Master => */
        /*     <> */
        /*         <p className="left-aligned"> {React.string(t("You are currently hosting a game."))} </p> */
        /*         <p> {React.string(t("If you want to join a running game, you should stop hosting first."))} </p> */
        /*         <Spacer /> */
        /*         <Button */
        /*             label={t("Stop Hosting")} */
        /*             onClick={ _event => stopHosting( */
        /*                 dbConnectionStatus, setDbConnectionStatus, gameState, setGameState */
        /*             ) } */
        /*         /> */
        /*     </> */
        | Slave(_) | StandAlone =>
            <>
                <p>
                    {React.string(t(
                        // needs backticks for unicode arrow
                        `Take the other smartphone and look in the app under Settings → Host Game. ` ++
                        "Then enter the game code here."
                    ))}
                </p>
                <Spacer />
                <input
                    type_="text" id={inputElementId} className="id-input"
                    maxLength=15 defaultValue placeholder onChange
                />
                {connectionStatus}
                <Spacer />
                // Back/Forward buttons
                <ButtonPair>
                    <Button label={t("Back")} className="icon-left icon-back" onClick=onBack />
                    <Button label={t("Next")} className="icon-right icon-forw condensed-nl" onClick=onForward />
                </ButtonPair>
            </>
    }

    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <BackFloatingButton onClick=onBack />
        <GearFloatingButton goToPage returnPage=SetupSlave />
        <h1 className="condensed-es" >
            {React.string(t("Join Game"))}
        </h1>
        <Spacer />
        <p> {React.string(t("It is possible to join a game running on another smartphone."))} </p>
        {modusOperandi}
    </div>
}

