/* *****************************************************************************
 * DaytimeRevealPage
 */

open Types

@react.component
let make = (~goToPage, ~allowBackToConfess: bool=true): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)
  let (turnState, _) = React.useContext(TurnStateContext.context)

  let (witchTargetRevealed, setWitchTargetRevealed) = React.useState(_ => false)
  let (constableTargetRevealed, setConstableTargetRevealed) = React.useState(_ => false)

  let (witchesRevealPrompt, witchesRevelationPromptPre, witchesRevelationPromptPost) = switch (
    turnState.nrWitches,
    turnState.nightType,
  ) {
  | (One, Dawn) => (t("Reveal witch's victim"), "", t(" got the black cat"))
  | (More, Dawn) => (t("Reveal witches' victim"), "", t(" got the black cat"))
  | (One, Night) => (
      t("Reveal witch's victim"),
      t("The witch attacked-PRE"),
      t("The witch attacked-POST"),
    )
  | (More, Night) => (
      t("Reveal witches' victim"),
      t("The witches attacked-PRE"),
      t("The witches attacked-POST"),
    )
  }

  let witchesRevealButton = switch turnState.choiceWitches {
  | None => React.null
  | Some(witchTargetName) =>
    <LargeRevealButton
      revealPrompt=witchesRevealPrompt
      revelationPromptPre=witchesRevelationPromptPre
      revelationPromptPost=witchesRevelationPromptPost
      secret=witchTargetName
      revealed=witchTargetRevealed
      onClick={_event => setWitchTargetRevealed(prev => !prev)}
    />
  }

  let constableRevealButton = switch turnState.choiceConstable {
  | None => React.null
  | Some(constableTargetName) =>
    <LargeRevealButton
      revealPrompt={t(`Reveal constable's protégé`)}
      revelationPromptPre={t("The constable protected-PRE")}
      revelationPromptPost={t("The constable protected-POST")}
      secret=constableTargetName
      revealed=constableTargetRevealed
      onClick={_event => setConstableTargetRevealed(prev => !prev)}
    />
  }

  let freeToProceed =
    witchTargetRevealed && (constableTargetRevealed || turnState.choiceConstable === None)

  let backToConfessButton =
    <Button
      label={t("Back")}
      className="icon-left icon-back"
      onClick={_event => goToPage(_prev => DaytimeConfess)}
    />
  let forwardToDaytimeButton =
    <Button
      label={t("Next")}
      disabled={!freeToProceed}
      className="icon-right icon-forw condensed-nl last"
      onClick={_event => goToPage(_prev => Daytime)}
    />

  let returnPage = allowBackToConfess ? DaytimeReveal : DaytimeRevealNoConfess

  // component
  <div id="daytime-reveal-page" className="page justify-spread">
    <TopBar>
      {if allowBackToConfess {
        <BackFloatingButton onClick={_event => goToPage(_prev => DaytimeConfess)} />
      } else {
        React.null
      }}
      <GearFloatingButton goToPage returnPage />
    </TopBar>
    <h1 className="condensed-de"> {React.string(t("The Reveal"))} </h1>
    <p className="text-centered">
      {React.string(t("Find out what happened while you were sleeping."))}
    </p>
    <Spacer />
    {witchesRevealButton}
    {constableRevealButton}
    <Spacer verticalFill=true />
    {
      // Back/Forward buttons

      if allowBackToConfess {
        <ButtonPair>
          {backToConfessButton}
          {forwardToDaytimeButton}
        </ButtonPair>
      } else {
        {forwardToDaytimeButton}
      }
    }
  </div>
}
