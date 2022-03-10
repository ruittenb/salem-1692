/** ****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {

    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let (navigation, setNavigation) = React.useContext(NavigationContext.context)
    let t = Translator.getTranslator(gameState.language)

    let togglePlayEffects = () => {
        setGameState(prevGameState => {
            ...prevGameState,
            doPlayEffects: !prevGameState.doPlayEffects
        })
    }

    let togglePlaySpeech = () => {
        setGameState(prevGameState => {
            ...prevGameState,
            doPlaySpeech: !prevGameState.doPlaySpeech
        })
    }

    let togglePlayMusic = () => {
        setGameState(prevGameState => {
            ...prevGameState,
            doPlayMusic: !prevGameState.doPlayMusic
        })
    }

    React.useEffect0(() => {
        if (gameState.backgroundMusic->Js.Array2.length === 0) {
            setGameState(prevGameState => {
                ...prevGameState,
                doPlayMusic: false
            })
        }
        // Cleanup function
        None
    })

    <div id="setup-page" className="page justify-start">
        <BackFloatingButton
            onClick={ _event => {
                setNavigation(_prev => None)
                goToPage(_prev => navigation->Belt.Option.getWithDefault(Title))
            } }
        />
        <h1 className="condensed-fr condensed-es condensed-de"> {React.string(t("Settings"))} </h1>
        <Spacer />
        <Button
            label={t("Players")}
            className="icon-left icon-pawn"
            onClick={ _event => goToPage(_prev => SetupPlayers) }
        />
        <Button
            label={t("Language")}
            className="icon-left icon-lang"
            onClick={ _event => goToPage(_prev => SetupLanguage) }
        />
        <Button
            label={t("Sound effects")}
            className={"condensed-nl icon-left " ++ if gameState.doPlayEffects { "icon-checked" } else { "icon-unchecked" }}
            onClick={ _event => togglePlayEffects() }
        />
        <Button
            label={t("Speech")}
            className={"icon-left " ++ if gameState.doPlaySpeech { "icon-checked" } else { "icon-unchecked" }}
            onClick={ _event => togglePlaySpeech() }
        />
        <Button
            label={t("Music")}
            className={"icon-left " ++ if gameState.doPlayMusic { "icon-checked" } else { "icon-unchecked" }}
            onClick={ _event => {
                if gameState.doPlayMusic {
                    togglePlayMusic()
                } else {
                    togglePlayMusic()
                    goToPage(_prev => SetupMusic)
                }
            } }
        />
        <Button
            label={t("Credits")}
            onClick={ _event => goToPage(_prev => Credits) }
        />
    </div>
}


