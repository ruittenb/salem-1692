
/** ****************************************************************************
 * LanguageList
 *
 * Flag icons: https://flagcdn.com/w20/nl.png
 */

open Types

@react.component
let make = (
    ~setLanguage,
    ~goToPage,
): React.element => {
    let currentLanguage = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(currentLanguage)
    let buttons = [ NL_NL, EN_US, ES_ES ] // is there no way to retrieve these dynamically?
        ->Belt.Array.map(lang => {
            let onClick: (ReactEvent.Mouse.t => unit) = _event => setLanguage(_prev => lang)
            let (className, label) = switch lang {
                | NL_NL => ("flag flag_nl", t("Nederlands"))
                | EN_US => ("flag flag_us", t("English"))
                | ES_ES => ("flag flag_es", t(`Español`))
            }
            <Button key={label} label className onClick />
        })
    <>
        <div> {React.string(t("Language"))} </div>
        <Spacer />
        {React.array(buttons)}
        <Spacer />
        <Button label={t("Back")} onClick={ _event => goToPage(_prev => Setup) } />
    </>
}

