/* *****************************************************************************
 * NightWaitingPage
 */

open Types

@react.component
let make = (~goToPage): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)
  let (turnState, _setTurnState) = React.useContext(TurnStateContext.context)

  let titleAndSpacer = if turnState.nightType === Dawn {
    <> <h1> {React.string(t("Dawn"))} </h1> <Spacer /> <Spacer /> </>
  } else {
    <> <h1> {React.string(t("Night"))} </h1> <Eyes /> </>
  }

  // Construct the core element for this page
  <div className="page justify-spread">
    {titleAndSpacer}
    <p className="text-centered">
      {React.string(t("Everybody is sound asleep... what about you?"))}
    </p>
    <Spacer verticalFill=true />
    <Button
      label={t("Abort")}
      className="icon-left icon-abort last"
      onClick={_event => goToPage(_prev => SetupNetwork)}
    />
  </div>
}
