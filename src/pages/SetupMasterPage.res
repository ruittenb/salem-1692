
/** ****************************************************************************
 * SetupMasterPage
 */

open Types
open Types.FbDb

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (maybeDbConnection, setDbConnection) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (connectionStatus, setConnectionStatus) = React.useState(_ => {
        switch gameState.gameType {
            | StandAlone => NotConnected
            | Master     => Connected
            | Slave(_)   => Connected
        }
    })

    let startHosting = () => {
        setConnectionStatus(_prev => Connecting)
        Firebase.connect()
            ->Promise.then(dbConnection => {
                setDbConnection(_prev => Some(dbConnection))
                setConnectionStatus(_prev => Connected)
                setGameState(prevGameState => {
                    let newGameState = {
                        ...prevGameState,
                        gameType: Master,
                        gameId: GameId.getGameId()
                    }
                    Firebase.createGame(dbConnection, newGameState)
                    newGameState
                })
                Promise.resolve(true)
            })
            ->ignore
    }

    let stopHosting = () => {
        switch maybeDbConnection {
            | None               => ()
            | Some(dbConnection) => {
                Firebase.disconnect(dbConnection)
                setConnectionStatus(_prev => NotConnected)
                setGameState((prevGameState) => {
                    ...prevGameState,
                    gameType: StandAlone
                })
            }
        }
    }

    let connectionStatus = switch (connectionStatus) {
        | NotConnected => React.null
        | Connecting   => <>
                              <Spacer />
                              {React.string("Connecting...")}
                          </>
        | Connected    => <>
                              <Spacer />
                              {React.string("Connected")}
                          </>
    }

    // component
    <div id="setup-master-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => Setup) } />
        <h1> {React.string(t("Host Game"))} </h1>
        <Spacer />
        <p> {React.string(t("It is possible to join this game from another smartphone."))} </p>
        {
            if (gameState.gameType !== Master) {
                <>
                    {connectionStatus}
                    <Spacer />
                    <Button
                        label={t("Start Hosting")}
                        className="condensed-fr"
                        onClick={ _event => startHosting() }
                    />
                </>
            } else {
                <>
                    <p>
                        {React.string(t(
                            "Take the other smartphone and look in the app under Join Game. Then enter the following game code there."
                        ))}
                    </p>
                    <Spacer />
                    <div className="id-input"> {React.string(gameState.gameId)} </div>
                    <Spacer />
                    <QR value=gameState.gameId />
                    <Spacer />
                    <Spacer />
                    <Button
                        label={t("Stop Hosting")}
                        onClick={ _event => stopHosting() }
                    />
                </>
            }
        }
    </div>
}


