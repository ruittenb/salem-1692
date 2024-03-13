/* *****************************************************************************
 * TitlePage
 */

open Types

@react.component
let make = (~goToPage): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let currentPage = Title

  <div id="title-page" className="page justify-start">
    <GearFloatingButton goToPage returnPage=currentPage />
    <Button label={t("Play Game")} onClick={_event => goToPage(_prev => Daytime)} />
    <Button label={t("Multi-Telephone")} onClick={_event => goToPage(_prev => SetupNetwork)} />
    <Button label={t("Exit")} onClick={_event => goToPage(_prev => Close)} className="last" />
  </div>
}
