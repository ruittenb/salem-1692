
/** ****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Setup"))} </h1>
        <LanguageList />
    </div>
}


