
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Spelers"))} </h1>
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon_left icon_back"
        />
    </div>
}


