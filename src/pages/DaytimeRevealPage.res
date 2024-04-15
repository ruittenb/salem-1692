/* *****************************************************************************
 * DaytimeRevealPage
 */

open Types
open PlayerCodec

@react.component
let make = (~allowBackToConfess: bool=true): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
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
  let constableRevealPrompt = t(`Reveal constable's protégé`)

  let targetName = (target: PlayerCodec.t) =>
    switch target {
    | Undecided => ""
    | Nobody => t("nobody-OBJ")
    | Player(playerName) => playerName
    }

  let witchesRevealButton = switch turnState.choiceWitches {
  | Undecided => React.null
  | witchTarget =>
    // The "nobody" variant of this text is probably ungrammatical in
    // many languages, but this scenario should not happen anyway.
    <LargeRevealButton
      revealPrompt=witchesRevealPrompt
      revelationPromptPre=witchesRevelationPromptPre
      revelationPromptPost=witchesRevelationPromptPost
      secret={targetName(witchTarget)}
      revealed=witchTargetRevealed
      onClick={_event => setWitchTargetRevealed(prev => !prev)}
    />
  }

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
    <LargeRevealButton
      revealPrompt={constableRevealPrompt}
      revelationPromptPre={t("The constable protected-PRE")}
      revelationPromptPost={t("The constable protected-POST")}
      secret={constableTargetName}
      revealed=constableTargetRevealed
      onClick={_event => setConstableTargetRevealed(prev => !prev)}
    />
  }

  let freeToProceed =
    witchTargetRevealed && (constableTargetRevealed || turnState.choiceConstable === Undecided)

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
    <TopBar
      returnPage=Some(returnPage)
      onBack={allowBackToConfess ? Some(_event => goToPage(_prev => DaytimeConfess)) : None}
    />
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
