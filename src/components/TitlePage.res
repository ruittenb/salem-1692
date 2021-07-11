
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
        <Button label={t("New Game")} onClick={ goToPage(_ => DayTime) } />
        <Button label={t("Setup"   )} onClick={ goToPage(_ => Setup  ) } />
        <Button label={t("Exit"    )} onClick={ goToPage(_ => Exit   ) } className="last" />
    </div>
}

