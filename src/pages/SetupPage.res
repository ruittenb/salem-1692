
/** ****************************************************************************
 * SetupPage
 *
 * Language, player names, nr. witches, credits
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Setup"))} </h1>
        <Spacer />
        <Button
            label={t("Language")}
            onClick={ _event => goToPage(_prev => SetupLanguage) }
        />
        <Button
            label={t("Credits")}
            onClick={ _event => goToPage(_prev => Credits) }
        />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Title) }
            className="icon icon_back"
        />
    </div>
}


