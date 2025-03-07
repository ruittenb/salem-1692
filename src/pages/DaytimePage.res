/* *****************************************************************************
 * DaytimePage
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (_, setTurnState) = React.useContext(TurnStateContext.context)
  let defaultNextState = {
    nrWitches: More,
    nightType: Dawn,
    choiceWitches: PlayerCodec.Undecided,
    choiceConstable: PlayerCodec.Undecided,
  }

  let returnPage = switch gameState.gameType {
  | Master(_) => SetupNetwork
  | _ => Title
  }

  // Page element
  <div id="daytime-page" className="page justify-start">
    <TopBar returnPage=Some(Daytime) onBack={Some(_event => goToPage(_prev => returnPage))} />
    <h1> {React.string(t("A day in Salem"))} </h1>
    <Spacer />
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nrWitches: One})
        goToPage(_prev => NightDawnOneWitch)
      }}>
      {React.string(t("Dawn,"))}
      <br />
      {React.string(t("one witch"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => defaultNextState)
        goToPage(_prev => NightDawnMoreWitches)
      }}>
      {React.string(t("Dawn,"))}
      <br />
      {React.string(t("several witches"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nightType: Night})
        goToPage(_prev => NightOtherWithConstable)
      }}>
      {React.string(t("Night,"))}
      <br />
      {React.string(t("with constable"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nightType: Night})
        goToPage(_prev => NightOtherNoConstable)
      }}>
      {React.string(t("Night,"))}
      <br />
      {React.string(t("without constable"))}
    </LargeButton>
  </div>
}
