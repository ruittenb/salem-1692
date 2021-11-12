
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

    <div id="daytime-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => Title) } />
        <GearFloatingButton goToPage returnPage=Daytime />
        <h1> {React.string(t("Daytime"))} </h1>
        <Spacer />
        <LargeButton onClick={ _event => {
            setTurnState(_prev => { ...defaultNextState, nrWitches: One })
            goToPage(_prev => NightFirstOneWitch)
        } } >
            {React.string(t("First night,"))} <br />
            {React.string(t("one witch"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightFirstMoreWitches)
        } } >
            {React.string(t("First night,"))} <br />
            {React.string(t("more witches"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightOtherWithConstable)
        } } >
            {React.string(t("Other nights,"))} <br />
            {React.string(t("with constable"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => NightOtherNoConstable)
        } } >
            {React.string(t("Other nights,"))} <br />
            {React.string(t("without constable"))}
        </LargeButton>
    </div>
}


