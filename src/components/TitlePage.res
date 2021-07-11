
/** ****************************************************************************
 * TitlePage
 */

open Types

@react.component
let make = (
    ~goToPage
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="title-page" className="page flex-vertical">
        <Button label={t("New Game")} onClick={ _event => goToPage(_prev => DayTime) } />
        <Button label={t("Setup"   )} onClick={ _event => goToPage(_prev => Setup  ) } />
        <Button label={t("Exit"    )} onClick={ _event => goToPage(_prev => Exit   ) } className="last" />
    </div>
}

