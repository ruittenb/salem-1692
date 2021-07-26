
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
                | NL_NL => ("icon-left flag-nl", t("Nederlands"))
                | EN_US => ("icon-left flag-us", t("English"))
                | ES_ES => ("icon-left flag-es", t(`Español`))
            }
            <Button key={label} label className onClick />
        })
    <>
        <h2>{ React.string(t("Language")) }</h2>
        <Spacer />
        {React.array(buttons)}
    </>
}

