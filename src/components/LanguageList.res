/* *****************************************************************************
 * LanguageList
 *
 * Flag icons: https://flagcdn.com/w20/nl.png
 */

open Types

@react.component
let make = (~goToPage): React.element => {
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let offeredLanguages: array<LanguageCodec.t> = [
    #en_US,
    #es_ES,
    #fr_FR,
    #it_IT,
    #pt_BR,
    #de_DE,
    #nl_NL,
    //#uk_UA,
  ]

  let buttons: array<React.element> = offeredLanguages->Belt.Array.map(buttonLanguage => {
    let onClick: clickHandler = _event => {
      let newGameState = {
        ...gameState,
        language: buttonLanguage,
      }
      setGameState(_prevState => newGameState)
      goToPage(_prev => Setup)
    }
    let (className, label) = switch buttonLanguage {
    | #en_US => ("icon-left compact flag flag-us-gb", t("English"))
    | #es_ES => ("icon-left compact flag flag-es", t(`Español`))
    | #pt_BR => ("icon-left compact flag flag-br", t(`Português`))
    | #fr_FR => ("icon-left compact flag flag-fr", t(`Français`))
    | #it_IT => ("icon-left compact flag flag-it", t("Italiano"))
    | #de_DE => ("icon-left compact flag flag-de", t("Deutsch"))
    | #nl_NL => ("icon-left compact flag flag-nl", t("Nederlands"))
    | #uk_UA => ("icon-left compact flag flag-ua uk_UA", t(`Українська`))
    }
    <Button key={label} label className onClick />
  })

  // React component
  <>
    {React.array(buttons)}
    // Incomplete languages may use React.string(t("Interface only, no dialogue yet"))
  </>
}