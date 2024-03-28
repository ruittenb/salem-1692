/* *****************************************************************************
 * LanguageList
 *
 * Flag icons: https://flagcdn.com/w20/nl.png
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
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
    //#ja_JP,
    //#ko_KR,
  ]

  let languageToButton = (buttonLanguage, index) => {
    let onClick: clickHandler = _event => {
      let newGameState = {
        ...gameState,
        language: buttonLanguage,
      }
      setGameState(_prevState => newGameState)
      goToPage(_prev => Setup)
    }
    let (classNames, label) = switch buttonLanguage {
    | #en_US => ("icon-top oblongbutton compact flag flag-us-gb", t("English"))
    | #es_ES => ("icon-top oblongbutton compact flag flag-es", t(`Español`))
    | #pt_BR => ("icon-top oblongbutton compact flag flag-br", t(`Português`))
    | #fr_FR => ("icon-top oblongbutton compact flag flag-fr", t(`Français`))
    | #it_IT => ("icon-top oblongbutton compact flag flag-it", t("Italiano"))
    | #de_DE => ("icon-top oblongbutton compact flag flag-de", t("Deutsch"))
    | #nl_NL => ("icon-top oblongbutton compact flag flag-nl", t("Nederlands"))
    | #uk_UA => ("icon-top oblongbutton compact flag flag-ua uk_UA", t(`Українська`))
    | #ja_JP => ("icon-top oblongbutton compact flag flag-jp ja_JP", t(`日本語`))
    | #ko_KR => ("icon-top oblongbutton compact flag flag-kr ko_KR", t(`한국어`))
    }
    let widthClass = index == 0 ? "grid-wide" : ""
    <Button key={label} label className={classNames ++ " " ++ widthClass} onClick />
  }

  let buttons: array<React.element> = offeredLanguages->Js.Array2.mapi(languageToButton)

  // React component
  <div id="language-list">
    {React.array(buttons)}
    // Incomplete languages may use React.string(t("Interface only, no dialogue yet"))
  </div>
}
