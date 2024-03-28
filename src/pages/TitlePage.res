/* *****************************************************************************
 * TitlePage
 */

open Types

@react.component
let make = (): React.element => {
  let (currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  <div id="title-page" className="page justify-start">
    <GearFloatingButton returnPage=currentPage />
    <Button label={t("Play Game")} onClick={_event => goToPage(_prev => Daytime)} />
    <Button label={t("Multi-Telephone")} onClick={_event => goToPage(_prev => SetupNetwork)} />
    <Button label={t("Exit")} onClick={_event => goToPage(_prev => Close)} className="last" />
  </div>
}
