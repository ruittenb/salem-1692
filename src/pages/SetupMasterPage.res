
/** ****************************************************************************
 * SetupMasterPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let startHosting = () => {
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: Master,
            gameId: GameId.getGameId()
        })
    }

    let stopHosting = () => {
        setGameState((prevGameState) => {
            ...prevGameState,
            gameType: StandAlone
        })
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
                    <Spacer />
                    <Button
                        label={t("Start Hosting")}
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


