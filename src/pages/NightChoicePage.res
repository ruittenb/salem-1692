
/** ****************************************************************************
 * NightChoicePage
 */

open Types

@react.component
let make = (
    ~children: React.element,
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
            {children}
        </div>
    </div>
}

