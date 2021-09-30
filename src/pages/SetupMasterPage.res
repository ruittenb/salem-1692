
/** ****************************************************************************
 * SetupMasterPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let gameId = switch gameState.gameType {
        | Master(gameId) => gameId
        | StandAlone
        | Slave(_)       => GameId.getGameId() // TODO assign to gamestate
    }

    // component
    <div id="setup-master-page" className="page flex-vertical">
        <h1> {React.string(t("Game ID"))} </h1>
        <Spacer />
        // TODO tekst over hoe dit werkt
        <div className="input"> {React.string(gameId)} </div>
        <Spacer />
        <QR value=gameId />
        <Spacer />
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => Setup) }
        />
    </div>
}


