
/** ****************************************************************************
 * LanguageList
 *
 * Flag icons: https://flagcdn.com/w20/nl.png
 */

open Types
open Constants

let saveLanguageToLocalStorage = (language: language): unit => {
    let storageKey = localStoragePrefix ++ localStorageLanguageKey
    LocalStorage.setItem(storageKey, Translator.getLanguageCode(language))
}

@react.component
let make = (
    ~setLanguage,
    ~goToPage,
): React.element => {

    let (_language, t) = React.useContext(LanguageContext.context)

    let buttons = [ NL_NL, EN_US, ES_ES ] // is there no way to retrieve these dynamically?
        ->Belt.Array.map(buttonLanguage => {
            let onClick: clickHandler = _event => {
                saveLanguageToLocalStorage(buttonLanguage)
                setLanguage(_prev => buttonLanguage)
                goToPage(_prev => Setup)
            }
            let (className, label) = switch buttonLanguage {
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

