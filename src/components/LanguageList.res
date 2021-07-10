
/** ****************************************************************************
 * LanguageList
 */

open Types

@react.component
let make = (~state: state): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    let buttons = [ NL_NL, EN_US, ES_ES ]
        ->Belt.Array.map((lang) => {
            let label = switch lang {
                | NL_NL => t("Nederlands")
                | EN_US => t("English")
                | ES_ES => t("Español")
            }
            <Button key={label} label={label} />
        })
    <>
        {React.string(t("Choose language"))}
        {React.array(buttons)}
    </>
}

