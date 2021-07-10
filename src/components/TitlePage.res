
/** ****************************************************************************
 * TitlePage
 */

@react.component
let make = (): React.element => {
    let locale = React.useContext(LocaleContext.context)
    let t = Translator.getTranslator(locale)
    <div id="title-page" className="page flex-vertical">
        <Button label={t("New Game")} />
        <Button label={t("Setup"   )} />
        <Button label={t("Exit"    )} className="last" />
    </div>
}

