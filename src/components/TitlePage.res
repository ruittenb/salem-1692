
/** ****************************************************************************
 * TitlePage
 */

@react.component
let make = (): React.element => {
    let locale = React.useContext(Context.Locale.context)
    let t = Translator.getTranslator(locale)
    <div id="title-page" className="page">
        <Button label={t("New Game")} />
        <Button label={t("Setup"   )} />
        <Button label={t("Exit"    )} className="last" />
    </div>
}

