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
    /* #pt_BR, */
    #fr_FR,
    #de_DE,
    #nl_NL,
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
    | #en_US => ("icon-left flag-us", t("English"))
    | #es_ES => ("icon-left flag-es", t(`Español`))
    | #pt_BR => ("icon-left flag-br", t(`Português`))
    | #fr_FR => ("icon-left flag-fr", t(`Français`))
    | #de_DE => ("icon-left flag-de", t("Deutsch"))
    | #nl_NL => ("icon-left flag-nl", t("Nederlands"))
    }
    <Button key={label} label className onClick />
  })

  // React component
  <>
    {React.array(buttons)}
    // Incomplete languages may use React.string(t("Interface only, no dialogue yet"))
  </>
}