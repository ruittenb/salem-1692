
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

    let gameId = switch gameState.gameType {
        | Master(gameId) => gameId
        | StandAlone
        | Slave(_)       => GameId.getGameId()
    }

    let applyGameId = (gameId: string): unit => {
        setGameState((prevGameState) => {
            let newGameState = {
                ...prevGameState,
                gameType: Master(gameId)
            }
            LocalStorage.saveGameState(newGameState)
            newGameState
        })
    }

    let generateNewGameId = () => {
        GameId.getGameId()->applyGameId
    }

    // Runs after every completed render
    React.useEffect(() => {
        if (gameState.gameType != Master(gameId)) {
            applyGameId(gameId)
        }
        None // cleanup function
    })

    // component
    <div id="setup-master-page" className="page flex-vertical">
        <h1> {React.string(t("Game ID"))} </h1>
        <Spacer />
        <div className="paragraph">
            {React.string(t("It is possible to join this game from another smartphone."))}
            <br />
            <br />
            {React.string(t("Take the other smartphone and look in the app under Join Game. Then enter the following Game ID there."))}
        </div>
        <Spacer />
        <div className="input"> {React.string(gameId)} </div>
        <Spacer />
        <QR value=gameId />
        <Spacer />
        <Spacer />
        <Button
            label={t("New Game ID")}
            onClick={ _event => generateNewGameId() }
        />
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => Setup) }
        />
    </div>
}


