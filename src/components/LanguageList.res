
/** ****************************************************************************
 * LanguageList
 */

open Types

@react.component
let make = (): React.element => {
    let currentLanguage = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(currentLanguage)
    let buttons = [ NL_NL, EN_US, ES_ES ]
        ->Belt.Array.map((lang) => {
            let (className, label) = switch lang {
                | NL_NL => ("flag flag_nl", t("Nederlands"))
                | EN_US => ("flag flag_us", t("English"))
                | ES_ES => ("flag flag_es", t(`Español`))
            }
            <Button key={label} label className />
        })
    <>
        <div> {React.string(t("Language"))} </div>
        {React.array(buttons)}
    </>
}

