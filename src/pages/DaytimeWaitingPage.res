/* *****************************************************************************
 * DaytimeWaitingPage
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, _) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  // component
  <>
    <TopBar returnPage=None onBack={Some(_event => goToPage(_prev => SetupNetwork))} />
    <h1> {React.string(t("A day in Salem"))} </h1>
    <Spacer />
    <Spacer />
    <p className="text-centered">
      {React.string(t("Waiting for the host to announce nighttime..."))}
    </p>
    <Spacer verticalFill=true />
    <Button
      label={t("Abort")}
      className="icon-left icon-abort last"
      onClick={_event => goToPage(_prev => SetupNetwork)}
    />
  </>
}
