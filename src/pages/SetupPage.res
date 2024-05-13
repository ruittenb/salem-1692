/* *****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let (navigation, setNavigation) = React.useContext(NavigationContext.context)
  let (isBubbleVisible, setIsBubbleVisible) = React.useState(() => false)
  let t = Translator.getTranslator(gameState.language)

  let togglePlayEffects = () => {
    setGameState(prevGameState => {
      ...prevGameState,
      doPlayEffects: !prevGameState.doPlayEffects,
    })
  }

  let togglePlaySpeech = () => {
    setGameState(prevGameState => {
      ...prevGameState,
      doPlaySpeech: !prevGameState.doPlaySpeech,
    })
  }

  let togglePlayMusic = () => {
    setGameState(prevGameState => {
      ...prevGameState,
      doPlayMusic: !prevGameState.doPlayMusic,
    })
  }

  let hideBubble = () => {
    setIsBubbleVisible(_ => false)
  }

  let toggleKeepActive = () => {
    setIsBubbleVisible(_ => !gameState.doKeepActive)
    setGameState(prevGameState => {
      ...prevGameState,
      doKeepActive: !prevGameState.doKeepActive,
    })
  }

  React.useEffect0(() => {
    if gameState.backgroundMusic->Js.Array2.length === 0 {
      setGameState(prevGameState => {
        ...prevGameState,
        doPlayMusic: false,
      })
    }

    // Cleanup function
    None
  })

  // React element
  <div id="setup-page" className="page justify-start">
    <TopBar
      returnPage=None
      onBack={Some(
        _event => {
          setNavigation(_prev => None)
          goToPage(_prev => navigation->Belt.Option.getWithDefault(Title))
        },
      )}
    />
    <h1> {React.string(t("Settings"))} </h1>
    <Spacer />
    <Button
      label={t("Players")}
      className="icon-left icon-pawn"
      onClick={_event => goToPage(_prev => SetupPlayers)}
    />
    <Button
      label={t("Language")}
      className="icon-left icon-lang"
      onClick={_event => goToPage(_prev => SetupLanguage)}
    />
    <Button
      label={t("Sound effects")}
      className={"condensed-nl condensed-pt condensed-uk icon-left " ++ if gameState.doPlayEffects {
        "icon-checked"
      } else {
        "icon-unchecked"
      }}
      onClick={_event => togglePlayEffects()}
    />
    <Button
      label={t("Speech")}
      className={"icon-left " ++ if gameState.doPlaySpeech {
        "icon-checked"
      } else {
        "icon-unchecked"
      }}
      onClick={_event => togglePlaySpeech()}
    />
    <Button
      label={t("Music")}
      className={"icon-left " ++ if gameState.doPlayMusic {
        "icon-checked"
      } else {
        "icon-unchecked"
      }}
      onClick={_event => {
        if gameState.doPlayMusic {
          togglePlayMusic()
        } else {
          togglePlayMusic()
          goToPage(_prev => SetupMusic)
        }
      }}
    />
    <If condition={isBubbleVisible}>
      <Bubble float=true dir=South clickHandler={_event => hideBubble()}>
        {React.string(
          t(
            "This keeps the screen active during the night, so that other players cannot see whether you used your phone.",
          ),
        )}
      </Bubble>
    </If>
    <Button
      label={t("Stay active")}
      className={"condensed-uk icon-left " ++ if gameState.doKeepActive {
        "icon-checked"
      } else {
        "icon-unchecked"
      }}
      onClick={_event => toggleKeepActive()}
    />
    <Button label={t("Credits")} onClick={_event => goToPage(_prev => Credits)} />
  </div>
}
