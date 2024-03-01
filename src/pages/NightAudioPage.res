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
  ~goToPage,
  ~goToNextStep=() => (),
  ~timerId: option<Js.Global.timeoutId>=?,
): React.element => {
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
      className="icon-left icon-abort condensed-nl condensed-de ultra-condensed-ua last"
      onClick={_event => goToPage(_prev => Daytime)}
    />
  let skipButton =
    <Button
      label={t("Skip")}
      className="icon-right icon-forw condensed-nl condensed-de ultra-condensed-ua"
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
      <ButtonPair> {abortButton} {skipButton} </ButtonPair>
    } else {
      React.null
    }}
  </>
}
