
/** ****************************************************************************
 * NightWaitingPage
 */

open Types

let p = "[NightWaitingPage] "

@react.component
let make = (
    ~goToPage,
): React.element => {

    // Language and translator
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // Construct the core element for this page
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            // vertically step past background eyes
            <Spacer />
            <Spacer />
            <Spacer />
            <p className="text-centered"> {React.string(t("Everybody is sound asleep... what about you?"))} </p>
            <Spacer />
            <Button
                label={t("Abort")}
                className="icon-left icon-abort"
                onClick={ _event => goToPage(_prev => SetupSlave) }
            />
        </div>
    </div>
}

