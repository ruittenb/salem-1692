
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
            let onClick: clickHandler = _event => {
                setLanguage(_prev => lang)
                goToPage(_prev => Setup)
            }
            let (className, label) = switch lang {
                | NL_NL => ("icon_left flag_nl", t("Nederlands"))
                | EN_US => ("icon_left flag_us", t("English"))
                | ES_ES => ("icon_left flag_es", t(`Español`))
            }
            <Button key={label} label className onClick />
        })
    <>
        <div> {React.string(t("Language"))} </div>
        <Spacer />
        {React.array(buttons)}
    </>
}

