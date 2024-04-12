/* *****************************************************************************
 * DaytimeConfessPage
 */

open Types
open PlayerCodec

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (dbConnectionStatus, _) = React.useContext(DbConnectionContext.context)
  let (turnState, _) = React.useContext(TurnStateContext.context)
  let (gameState, _) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (constableTargetRevealed, setConstableTargetRevealed) = React.useState(_ => false)

  let constableRevealPrompt = t(`Reveal constable's protégé`)

  let constableRevealButton = switch turnState.choiceConstable {
  | Undecided => React.null
  | Nobody =>
    <LargeRevealButton
      revealPrompt={constableRevealPrompt}
      revelationPromptPre={t("The constable did not protect anybody")}
      revelationPromptPost={""}
      secret={""}
      revealed=constableTargetRevealed
      onClick={_event => setConstableTargetRevealed(prev => !prev)}
    />
  | Player(constableTargetName) =>
    <>
      <Spacer />
      <LargeRevealButton
        revealPrompt={constableRevealPrompt}
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
    <TopBar returnPage=Some(DaytimeConfess) onBack={None} />
    <h1> {React.string(t("Confess"))} </h1>
    <h2> {React.string(t("Residents of Salem,"))} </h2>
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
