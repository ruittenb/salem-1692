
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

    let firstGamePage = if gameState.players->Belt.Array.length >= 2 {
        Daytime
    } else {
        SetupPlayersForGame(Title)
    }

    <div id="title-page" className="page flex-vertical">
        <SettingsGear goToPage returnPage=Title />
        <Button label={t("Play Game")} onClick={ _event => goToPage(_prev => firstGamePage) } />
        // <Button label={t("Setup"    )} onClick={ _event => goToPage(_prev => Setup(Title)) } />
        <Button label={t("Exit"     )} onClick={ _event => goToPage(_prev => Close) } className="last" />
    </div>
}

