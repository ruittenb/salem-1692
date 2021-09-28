
/** ****************************************************************************
 * SetupMasterPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // component
    <div id="setup-master-page" className="page flex-vertical">
        <h1> {React.string(t("Game ID"))} </h1>
        <Spacer />
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => Setup) }
        />
    </div>
}


