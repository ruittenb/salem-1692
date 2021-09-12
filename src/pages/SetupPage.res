
/** ****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {

    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let setAndSaveGameState = (newGameState: gameState): unit => {
        setGameState(_prevState => newGameState)
        LocalStorage.saveGameState(newGameState)
    }

    let togglePlayEffects = () => {
        setAndSaveGameState({
            ...gameState,
            doPlayEffects: !gameState.doPlayEffects
        })
    }

    let togglePlaySpeech = () => {
        setAndSaveGameState({
            ...gameState,
            doPlaySpeech: !gameState.doPlaySpeech
        })
    }

    let hasBackgroundMusic = gameState.backgroundMusic->Js.Array2.length > 0

    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Setup"))} </h1>
        <Spacer />
        <Button
            label={t("Players")}
            onClick={ _event => goToPage(_prev => SetupPlayers(Setup(returnPage))) }
        />
        <Button
            label={t("Language")}
            onClick={ _event => goToPage(_prev => SetupLanguage(returnPage)) }
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
            className={"icon-left " ++ if hasBackgroundMusic { "icon-checked" } else { "icon-unchecked" }}
            onClick={ _event => goToPage(_prev => SetupMusic(returnPage)) }
        />
        <Button
            label={t("Credits")}
            onClick={ _event => goToPage(_prev => Credits(returnPage)) }
        />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => returnPage) }
            className="icon-left icon-back"
        />
    </div>
}


