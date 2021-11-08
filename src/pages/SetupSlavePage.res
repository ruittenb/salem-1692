
/** ****************************************************************************
 * SetupSlavePage
 */

open Types
open Types.FbDb

let p = "[SetupSlavePage] "

let leaveAnyCurrentGame = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    Utils.ifConnected(dbConnectionStatus, (dbConnection) => {
        switch (gameState.gameType) {
            | Master        => {
                                   Utils.logDebug(p ++ "Stopping hosted game " ++ gameState.gameId)
                                   FirebaseClient.deleteGame(dbConnection, gameState.gameId)
                                   FirebaseClient.disconnect(dbConnection)
                               }
            | Slave(gameId) => {
                                   Utils.logDebug(p ++ "Leaving game " ++ gameId)
                                   FirebaseClient.leaveGame(dbConnection, gameId)
                                   FirebaseClient.disconnect(dbConnection)
                               }
            | StandAlone    => ()
        }
        setDbConnectionStatus(_prev => NotConnected)
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: StandAlone
        })
    })
}

let connectAndJoin = (setDbConnectionStatus, setGameState, newGameId) => {
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

    let (freeToProceed, setFreeToProceed) = React.useState(_ => false)

    let placeholder = "x00-x00-x00-x00"
    let defaultValue = switch gameState.gameType {
        | StandAlone    => ""
        | Master        => ""
        | Slave(gameId) => gameId
    }

    let onBlur = (event) => {
        let newGameId = ReactEvent.Focus.currentTarget(event)["value"]
        if (!GameId.isValid(newGameId)) {
            setFreeToProceed(_prev => false)
        } else {
            // TODO if already connected to current game, do nothing
            leaveAnyCurrentGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
            connectAndJoin(setDbConnectionStatus, setGameState, newGameId)
            setFreeToProceed(_prev => true)
        }
    }

    let onBack = (_event) => {
        leaveAnyCurrentGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
        goToPage(_prev => Title)
    }

    let onForward = (_event) => {
        goToPage(_prev => DaytimeWaiting)
    }

    let connectionStatus = switch (dbConnectionStatus) {
        | NotConnected => <p> {React.string(t("Not connected"))} </p>
        | Connecting   => <p> {React.string(t("Connecting..."))} </p>
        | Connected(_) => <p> {React.string(t("Connected."))} </p>
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
        <p>
            {React.string(t(
                // needs backticks for unicode arrow
                `Take the other smartphone and look in the app under Settings → Host Game. ` ++
                "Then enter the game code here."
            ))}
        </p>
        <Spacer />
        <input type_="text" className="id-input" maxLength=15 defaultValue placeholder onBlur />
        {connectionStatus}
        <Spacer />
        // Back/Forward buttons
        <ButtonPair>
            <Button
                label={t("Back")}
                className="icon-left icon-back"
                onClick=onBack
            />
            <Button
                label={t("Next")}
                disabled={!freeToProceed}
                className="icon-right icon-forw condensed-nl"
                onClick=onForward
            />
        </ButtonPair>
    </div>
}

