/* *****************************************************************************
 * DaytimeConfessPage
 */

open Types

@react.component
let make = (~goToPage): React.element => {
  let (dbConnectionStatus, _) = React.useContext(DbConnectionContext.context)
  let (turnState, _) = React.useContext(TurnStateContext.context)
  let (gameState, _) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (constableTargetRevealed, setConstableTargetRevealed) = React.useState(_ => false)

  let constableRevealButton = switch turnState.choiceConstable {
  | None => React.null
  | Some(constableTargetName) => <>
      <Spacer />
      <LargeRevealButton
        revealPrompt={t(`Reveal constable's protégé`)}
        revelationPromptPre={t("The constable protected-PRE")}
        revelationPromptPost={t("The constable protected-POST")}
        secret=constableTargetName
        revealed=constableTargetRevealed
        onClick={_event => setConstableTargetRevealed(prev => !prev)}
      />
    </>
  }

  // Runs only once right after mounting the component
  React.useEffect0(() => {
    // Clear turn data from database and revert to DaytimeWaiting
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, _gameId) => {
      FirebaseClient.saveGameState(
        dbConnection,
        gameState,
        DaytimeConfess,
        Constants.initialTurnState,
        None,
      )
    })
    None // cleanup
  })

  <div id="daytime-confess-page" className="page justify-spread">
    <GearFloatingButton goToPage returnPage=DaytimeConfess />
    <h1> {React.string(t("Confess"))} </h1>
    <h2> {React.string(t("Citizens of Salem,"))} </h2>
    <p className="text-centered">
      {React.string(t("those among you who wish to confess may now do so."))}
    </p>
    {constableRevealButton}
    <Spacer verticalFill=true />
    <Button
      label={t("Next")}
      className="icon-right icon-forw last"
      onClick={_event => goToPage(_prev => DaytimeReveal)}
    />
  </div>
}
