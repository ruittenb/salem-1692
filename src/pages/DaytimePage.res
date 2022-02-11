/** ****************************************************************************
 * DaytimePage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (_, setTurnState) = React.useContext(TurnStateContext.context)
    let defaultNextState = {
        nrWitches: More,
        choiceWitches: None,
        choiceConstable: None,
    }

    let (masterMode, returnPage) = switch gameState.gameType {
        | Master(_) => (true, SetupNetwork)
        | Slave(_)
        | StandAlone => (false, Title)
    }

    // Page element
    <div id="daytime-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => returnPage) } masterMode />
        <GearFloatingButton goToPage returnPage=Daytime />
        <h1> {React.string(t("Daytime"))} </h1>
        <Spacer />
        <LargeButton onClick={ _event => {
            setTurnState(_prev => { ...defaultNextState, nrWitches: One })
            goToPage(_prev => NightFirstOneWitch)
        } } >
            {React.string(t("Dawn,"))} <br />
            {React.string(t("one witch"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightFirstMoreWitches)
        } } >
            {React.string(t("Dawn,"))} <br />
            {React.string(t("several witches"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightOtherWithConstable)
        } } >
            {React.string(t("Night,"))} <br />
            {React.string(t("with constable"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightOtherNoConstable)
        } } >
            {React.string(t("Night,"))} <br />
            {React.string(t("without constable"))}
        </LargeButton>
    </div>
}


