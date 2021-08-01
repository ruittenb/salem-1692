
/** ****************************************************************************
 * TitlePage
 */

open Types

@react.component
let make = (
    ~goToPage
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (gameState, _) = React.useContext(GameStateContext.context)

    let firstGamePage = if gameState.players->Belt.Array.length > 0 { Daytime } else { SetupPlayersForGame }

    <div id="title-page" className="page flex-vertical">
        <Button label={t("Play Game")} onClick={ _event => goToPage(_prev => firstGamePage) } />
        <Button label={t("Setup"    )} onClick={ _event => goToPage(_prev => Setup) } />
        <Button label={t("Exit"     )} onClick={ _event => goToPage(_prev => Close) } className="last" />
    </div>
}

