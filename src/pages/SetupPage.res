
/** ****************************************************************************
 * SetupPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {

    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let togglePlayEffects = () => {
        setGameState(prev => {
            ...prev,
            doPlayEffects: !prev.doPlayEffects
        })
        LocalStorage.saveGameStateToLocalStorage(gameState)
    }

    let togglePlaySpeech = () => {
        setGameState(prev => {
            ...prev,
            doPlaySpeech: !prev.doPlaySpeech
        })
        LocalStorage.saveGameStateToLocalStorage(gameState)
    }

    let hasBackgroundMusic = gameState.backgroundMusic->Js.Array2.length > 0

    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Setup"))} </h1>
        <Spacer />
        <Button
            label={t("Players")}
            onClick={ _event => goToPage(_prev => SetupPlayers) }
        />
        <Button
            label={t("Language")}
            onClick={ _event => goToPage(_prev => SetupLanguage) }
        />
        <Button
            label={t("Sound effects")}
            className={"condensed_nl icon-left " ++ if gameState.doPlayEffects { "icon-checked" } else { "icon-unchecked" }}
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
            onClick={ _event => goToPage(_prev => SetupMusic) }
        />
        <Button
            label={t("Credits")}
            onClick={ _event => goToPage(_prev => Credits) }
        />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Title) }
            className="icon-left icon-back"
        />
    </div>
}


