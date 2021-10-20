
/** ****************************************************************************
 * SetupMasterPage
 */

open Types
open Types.FbDb
open Utils

let startHosting = (setDbConnectionStatus, setGameState) => {
    setDbConnectionStatus(_prev => Connecting)
    Firebase.connect()
        ->Promise.then(dbConnection => {
            setDbConnectionStatus(_prev => Connected(dbConnection))
            setGameState(prevGameState => {
                let newGameId = if prevGameState.gameType === Master {
                    // We already are Master. This happens when the Master state
                    // was read from localstorage. Reuse the old gameId.
                    prevGameState.gameId
                } else {
                    GameId.getGameId()
                }
                let newGameState = {
                    ...prevGameState,
                    gameType: Master,
                    gameId: newGameId
                }
                Firebase.createGame(dbConnection, newGameState)
                newGameState
            })
            Promise.resolve()
        })
        ->Promise.catch(error => {
            setDbConnectionStatus(_prev => NotConnected)
            error->getExceptionMessage->logError
            Promise.resolve()
        })
        ->ignore
}

let stopHosting = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
    ifConnected(dbConnectionStatus, (dbConnection) => {
        Firebase.destroyGame(dbConnection, gameState.gameId)
        Firebase.disconnect(dbConnection)
    })
    setDbConnectionStatus(_prev => NotConnected)
    setGameState((prevGameState) => {
        ...prevGameState,
        gameType: StandAlone
    })
}

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let connectionStatus = switch (dbConnectionStatus) {
        | NotConnected => <>
                              <Spacer />
                              <Button
                                  label={t("Start Hosting")}
                                  className="condensed-fr"
                                  onClick={ _event => startHosting(setDbConnectionStatus, setGameState) }
                              />
                          </>
        | Connecting   => <>
                              <Spacer />
                              {React.string("Connecting...")}
                          </>
        | Connected(_) => <>
                              <p>
                                  {React.string(t(
                                      "Take the other smartphone and look in the app under Join Game. " ++
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
                                  label={t("Stop Hosting")}
                                  onClick={ _event => stopHosting(
                                      dbConnectionStatus, setDbConnectionStatus, gameState, setGameState
                                  ) }
                              />
                          </>
    }

    // component
    <div id="setup-master-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => Setup) } />
        <h1> {React.string(t("Host Game"))} </h1>
        <Spacer />
        <p> {React.string(t("It is possible to join this game from another smartphone."))} </p>
        { connectionStatus }
    </div>
}


