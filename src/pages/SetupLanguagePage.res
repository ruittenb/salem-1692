/* *****************************************************************************
 * SetupLanguagePage
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  <div id="setup-language-page" className="page justify-start">
    <TopBar returnPage=None onBack={Some(_event => goToPage(_prev => Setup))} />
    <h1> {React.string(t("Language"))} </h1>
    <Spacer />
    <LanguageList />
    <Spacer />
    <Button label={t("OK")} className="ok-button" onClick={_event => goToPage(_prev => Setup)} />
  </div>
}
