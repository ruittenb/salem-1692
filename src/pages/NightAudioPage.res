
/** ****************************************************************************
 * NightAudioPage
 *
 * One audio step in a Night Scenario.
 * Used by NightScenarioPage and NightErrorPage
 */

open Types

let p = "[NightAudioPage] "

@react.component
let make = (
    ~error: bool = false,
    ~children: React.element,
    ~showNavButtons: bool = true,
    ~goToPage,
    ~goToNextStep = () => (),
    ~timerId: option<Js.Global.timeoutId> = ?,
): React.element => {

    // Language and translator
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let title = error ? "Error" : "Night"

    let abortButton = <Button
        label={t("Abort")}
        className="icon-left icon-abort condensed-nl condensed-de"
        onClick={ (_event) => goToPage(_prev => Daytime) }
    />
    let skipButton = <Button
        label={t("Skip")}
        className="icon-right icon-forw condensed-nl condensed-de"
        onClick={ (_event) => {
            timerId->Belt.Option.forEach(timerId => {
                Utils.logDebug(p ++ "Clearing timer")
                Js.Global.clearTimeout(timerId)
            })
            goToNextStep()
        } }
    />

    // Construct the core element for this page
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t(title))} </h1>
            // vertically step past background eyes
            <Spacer />
            <Spacer />
            <Spacer />
            {children}
            <Spacer />
            { if error {
                {abortButton}
            } else if showNavButtons {
                <ButtonPair>
                    {abortButton}
                    {skipButton}
                </ButtonPair>
            } else {
                React.null
            }}
        </div>
    </div>
}

