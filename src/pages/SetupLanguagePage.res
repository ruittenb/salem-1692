
/** ****************************************************************************
 * SetupLanguagePage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Language"))} </h1>
        <Spacer />
        <LanguageList goToPage />
        <Spacer />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon-left icon-back"
        />
    </div>
}


