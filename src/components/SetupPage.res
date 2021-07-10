
/** ****************************************************************************
 * SetupPage
 */

@react.component
let make = (): React.element => {
    let locale = React.useContext(LocaleContext.context)
    let t = Translator.getTranslator(locale)
    <div id="setup-page" className="page flex-vertical">
        <div> {React.string(t("Setup"))} </div>
        <div> {React.string("   ")} </div>
        <div> {React.string(t("Language"))} </div>
    </div>
}


