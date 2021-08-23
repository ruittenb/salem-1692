
/** ****************************************************************************
 * LanguageList
 *
 * Flag icons: https://flagcdn.com/w20/nl.png
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {

    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let allLanguages: array<LanguageCodec.t> = [ #NL_NL, #EN_US, #ES_ES ]

    let buttons: array<React.element> = allLanguages
        ->Belt.Array.map(buttonLanguage => {
            let onClick: clickHandler = _event => {
                let newGameState = {
                    ...gameState,
                    language: buttonLanguage
                }
                setGameState(_prevState => newGameState)
                LocalStorage.saveGameState(newGameState)
                goToPage(_prev => Setup)
            }
            let (className, label) = switch buttonLanguage {
                | #NL_NL => ("icon-left flag-nl", t("Nederlands"))
                | #EN_US => ("icon-left flag-us", t("English"))
                | #ES_ES => ("icon-left flag-es", t(`Español`))
            }
            <Button key={label} label className onClick />
        })
    <>
        <h2>{ React.string(t("Language")) }</h2>
        <Spacer />
        {React.array(buttons)}
    </>
}

