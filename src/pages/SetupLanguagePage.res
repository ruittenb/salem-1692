
/** ****************************************************************************
 * SetupLanguagePage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~setLanguage,
    ~goToPage,
): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)

    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Setup"))} </h1>
        <LanguageList setLanguage goToPage />
    </div>
}


