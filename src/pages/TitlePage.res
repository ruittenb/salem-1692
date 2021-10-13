
/** ****************************************************************************
 * TitlePage
 */

open Types

@react.component
let make = (
    ~goToPage
): React.element => {

    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let currentPage = Title

    let firstGamePage = if gameState.players->Js.Array.length >= 2 {
        Daytime
    } else {
        SetupPlayersForGame
    }

    <div id="title-page" className="page flex-vertical">
        <SettingsGear goToPage returnPage=currentPage />
        <Button label={t("Play Game")} onClick={ _event => goToPage(_prev => firstGamePage) } />
        <Button label={t("Join Game")} onClick={ _event => goToPage(_prev => SetupSlave) } disabled=true />
        // <Button label={t("Setup"    )} onClick={ _event => goToPage(_prev => Setup) } />
        <Button label={t("Exit"     )} onClick={ _event => goToPage(_prev => Close) } className="last" />
    </div>
}

