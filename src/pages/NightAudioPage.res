/* *****************************************************************************
 * NightAudioPage
 *
 * One audio step in a Night Scenario.
 * Used by NightScenarioPage and NightErrorPage
 */

open Types

let p = "[NightAudioPage] "

@react.component
let make = (
  ~error: bool=false,
  ~children: React.element,
  ~showNavButtons: bool=true,
  ~goToNextStep=() => (),
  ~timerId: option<Js.Global.timeoutId>=?,
): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  // Language and translator
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)
  let (turnState, _setTurnState) = React.useContext(TurnStateContext.context)

  let title = if error {
    "Error"
  } else if turnState.nightType === Dawn {
    "Dawn"
  } else {
    "Night"
  }

  let eyesImage =
    turnState.nightType === Dawn ? <Spacer verticalFill=true /> : <Eyes verticalFill=true />

  let abortButton =
    <Button
      label={t("Abort")}
      className="icon-left icon-abort condensed-it condensed-nl super-condensed-de super-condensed-uk super-condensed-hu last"
      onClick={_event => goToPage(_prev => Daytime)}
    />
  let skipButton =
    <Button
      label={t("Skip")}
      className="icon-right icon-forw condensed-nl super-condensed-de hyper-condensed-uk condensed-ko"
      onClick={_event => {
        timerId->Belt.Option.forEach(timerId => {
          Js.Global.clearTimeout(timerId)
          Utils.logDebug(p ++ "Clearing timer")
        })
        goToNextStep()
      }}
    />

  // Construct the core element for this page
  <>
    <h1> {React.string(t(title))} </h1>
    {eyesImage}
    {children}
    <Spacer verticalFill=true />
    {if error {
      abortButton
    } else if showNavButtons {
      <ButtonPair>
        {abortButton}
        {skipButton}
      </ButtonPair>
    } else {
      React.null
    }}
  </>
}