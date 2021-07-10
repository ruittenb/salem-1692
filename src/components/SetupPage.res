
/** ****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="setup-page" className="page flex-vertical">
        <div> {React.string(t("Setup"))} </div>
        <LanguageList />
    </div>
}


