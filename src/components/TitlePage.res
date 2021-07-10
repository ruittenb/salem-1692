
/** ****************************************************************************
 * TitlePage
 */

@react.component
let make = (): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="title-page" className="page flex-vertical">
        <Button label={t("New Game")} />
        <Button label={t("Setup"   )} />
        <Button label={t("Exit"    )} className="last" />
    </div>
}

