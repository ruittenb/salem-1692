/** ****************************************************************************
 * NightWaitingPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let (turnState, _setTurnState) = React.useContext(TurnStateContext.context)

    let title: string = (turnState.nightType === Dawn) ? "Dawn" : "Night"

    // Construct the core element for this page
    <div className="night-subpage page flex-vertical">
        <h1> {React.string(t(title))} </h1>
        // vertically step past background eyes
        <Spacer />
        <Spacer />
        <Spacer />
        <p className="text-centered"> {React.string(t("Everybody is sound asleep... what about you?"))} </p>
        <Spacer />
        <Button
            label={t("Abort")}
            className="icon-left icon-abort"
            onClick={ _event => goToPage(_prev => SetupNetwork) }
        />
    </div>
}

