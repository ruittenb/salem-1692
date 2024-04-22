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

  let offeredLanguages: array<LanguageCodec.t> = [
    #en_US,
    #es_ES,
    #fr_FR,
    #it_IT,
    #pt_BR,
    #de_DE,
    #nl_NL,
    //#uk_UA,
    #hu_HU,
    //#zh_CN,
    //#ja_JP,
    //#ko_KR,
    //#th_TH,
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
    | #en_US => ("icon-top oblongbutton compact flag flag-us-gb en_US", "English")
    | #es_ES => ("icon-top oblongbutton compact flag flag-es es_ES", `Español`)
    | #pt_BR => ("icon-top oblongbutton compact flag flag-br pt_BR", `Português`)
    | #fr_FR => ("icon-top oblongbutton compact flag flag-fr fr_FR", `Français`)
    | #it_IT => ("icon-top oblongbutton compact flag flag-it it_IT", "Italiano")
    | #de_DE => ("icon-top oblongbutton compact flag flag-de de_DE", "Deutsch")
    | #nl_NL => ("icon-top oblongbutton compact flag flag-nl nl_NL", "Nederlands")
    | #uk_UA => ("icon-top oblongbutton compact flag flag-ua uk_UA", `Українська`)
    | #hu_HU => ("icon-top oblongbutton compact flag flag-hu hu_HU", "Magyar")
    | #zh_CN => ("icon-top oblongbutton compact flag flag-cn zh_CN", `中文`)
    | #ja_JP => ("icon-top oblongbutton compact flag flag-jp ja_JP", `日本語`)
    | #ko_KR => ("icon-top oblongbutton compact flag flag-kr ko_KR", `한국어`)
    | #th_TH => ("icon-top oblongbutton compact flag flag-th th_TH", `ภาษาไทย`)
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
