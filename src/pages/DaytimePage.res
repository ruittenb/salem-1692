/* *****************************************************************************
 * DaytimePage
 */

open Types

@react.component
let make = (~goToPage): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (_, setTurnState) = React.useContext(TurnStateContext.context)
  let defaultNextState = {
    nrWitches: More,
    nightType: Dawn,
    choiceWitches: None,
    choiceConstable: None,
  }

  let (masterMode, returnPage) = switch gameState.gameType {
  | Master(_) => (true, SetupNetwork)
  | Slave(_)
  | StandAlone => (false, Title)
  }

  // Page element
  <div id="daytime-page" className="page justify-start">
    <BackFloatingButton onClick={_event => goToPage(_prev => returnPage)} />
    <GearFloatingButton goToPage returnPage=Daytime />
    <MasterFloatingIcon masterMode />
    <h1> {React.string(t("A day in Salem"))} </h1>
    <Spacer />
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nrWitches: One})
        goToPage(_prev => NightDawnOneWitch)
      }}>
      {React.string(t("Dawn,"))} <br /> {React.string(t("one witch"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => defaultNextState)
        goToPage(_prev => NightDawnMoreWitches)
      }}>
      {React.string(t("Dawn,"))} <br /> {React.string(t("several witches"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nightType: Night})
        goToPage(_prev => NightOtherWithConstable)
      }}>
      {React.string(t("Night,"))} <br /> {React.string(t("with constable"))}
    </LargeButton>
    <LargeButton
      onClick={_event => {
        setTurnState(_prev => {...defaultNextState, nightType: Night})
        goToPage(_prev => NightOtherNoConstable)
      }}>
      {React.string(t("Night,"))} <br /> {React.string(t("without constable"))}
    </LargeButton>
  </div>
}
