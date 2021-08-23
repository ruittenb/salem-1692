
/** ****************************************************************************
 * NightStepPage
 *
 * One step in a Night Scenario.
 * Used by NightScenarioPage and NightErrorPage
 */

open Types

@react.component
let make = (
    ~title: string = "Night", // must not have been translated yet
    ~children: React.element,
    ~showAbortButton: bool = true,
    ~goToPage,
): React.element => {

    // Language and translator
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // Construct the core element for this page
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t(title))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            {children}
            <Spacer />
            { if showAbortButton {
                <Button
                    label={t("Abort")}
                    className="icon-left icon-abort"
                    onClick={ (_event) => goToPage(_prev => Daytime) }
                />
            } else {
                React.null
            }}
        </div>
    </div>
}

