/* *****************************************************************************
 * SetupPlayersPage
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, _) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  <div id="setup-players-page" className="page justify-start">
    <TopBar returnPage=None onBack={Some(_event => goToPage(_prev => Setup))} />
    <h1> {React.string(t("Players"))} </h1>
    <PlayerForm />
    <Spacer />
    <GhostForm />
    <SeatingForm />
    <Button
      label={t("OK")} onClick={_event => goToPage(_prev => Setup)} className="spacer-top ok-button"
    />
  </div>
}
