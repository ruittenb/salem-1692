
/** ****************************************************************************
 * SetupNetworkPage
 */

open Types
open Utils

let p = "[SetupNetworkPage] "

/**
 * Master functions
 */
let startHosting = (gameState, setGameState, setDbConnectionStatus) => {
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
            error->getExceptionMessage->logError
            Promise.resolve()
        })
        ->ignore
}

let stopHosting = (gameState, setGameState, dbConnectionStatus, setDbConnectionStatus) => {
    ifConnected(dbConnectionStatus, (dbConnection) => {
        FirebaseClient.deleteGame(dbConnection, gameState.gameId)
        FirebaseClient.disconnect(dbConnection)
    })
    setDbConnectionStatus(_prev => NotConnected)
    setGameState((prevGameState) => {
        ...prevGameState,
        gameType: StandAlone
    })
}

/**
 * Slave functions
 */

/**
 * Page functions
 */
let getModusOperandi = (
    t,
    goToPage,
    gameState,
    setGameState,
    dbConnectionStatus,
    setDbConnectionStatus
) => switch (gameState.gameType, dbConnectionStatus) {
    | (StandAlone, _) =>        <>
                                    <h2> {React.string(t("Be a Host"))} </h2>
                                    <p> {React.string(t("You may host a game so that people can join from another smartphone."))} </p>
                                    <Spacer />
                                    <Button
                                        label={t("Start Hosting")}
                                        className="condensed-fr"
                                        onClick={ _event => startHosting(
                                            gameState, setGameState, setDbConnectionStatus
                                        ) }
                                    />
                                    <Rule />
                                    <h2> {React.string(t("Be a Guest"))} </h2>
                                    <p> {React.string(t("You can join a game running on another smartphone."))} </p>
                                    <Spacer />
                                    <Button
                                        label={t("Join Game")}
                                        onClick={ _event => goToPage(_prev => SetupSlave) }
                                    />
                                </>
    | (Master, NotConnected) => <>
                                    <Spacer />
                                    <Button
                                        label={t("Start Hosting")}
                                        className="condensed-fr"
                                        onClick={ _event => startHosting(
                                            gameState, setGameState, setDbConnectionStatus
                                        ) }
                                    />
                                </>
    | (Master, Connecting) =>   <>
                                    <Spacer />
                                    {React.string(t("Connecting..."))}
                                </>
    | (Master, Connected(_)) => <>
                                    <h2> {React.string(t("Be a Host"))} </h2>
                                    <p>
                                        {React.string(t("You are currently hosting a game."))}
                                        {React.string(t(
                                            // needs backticks for unicode arrow
                                            `Take the other smartphone and look in the app under Multi-Telephone → Join Game. ` ++
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
                                        onClick=(_event => goToPage(_prev => Daytime))
                                    />
                                    <Rule />
                                    <h2> {React.string(t("Be a Guest"))} </h2>
                                    <p> {React.string(t("If you want to join a running game, you should stop hosting first."))} </p>
                                    <Button
                                        label={t("Stop Hosting")}
                                        className="condensed-nl"
                                        onClick={ _event => stopHosting(
                                            gameState, setGameState,
                                            dbConnectionStatus, setDbConnectionStatus,
                                        ) }
                                    />
                                </>
    | (Slave(_id), _) => logDebug(p ++ "Current Mode: Slave")
                    <></>
}

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {
    let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let modusOperandi = getModusOperandi(t, goToPage, gameState, setGameState, dbConnectionStatus, setDbConnectionStatus)


    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <BackFloatingButton onClick={(_event) => goToPage(_prev => returnPage)} />
        <GearFloatingButton goToPage returnPage=SetupNetwork />
        <h1 className="condensed-es" >
            {React.string(t("Multi-Telephone"))}
        </h1>
        {modusOperandi}
    </div>
}

