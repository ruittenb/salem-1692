
/** ****************************************************************************
 * SetupPage
 *
 * Language, player names, nr. witches, credits, TODO: reveal constable immediately
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let togglePlayEffects = () => setGameState(prev => {
        ...prev,
        doPlayEffects: !prev.doPlayEffects
    })

    let togglePlaySpeech = () => setGameState(prev => {
        ...prev,
        doPlaySpeech: !prev.doPlaySpeech
    })

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
            className={if gameState.doPlayEffects { "icon-left icon-checked" } else { "icon-left icon-unchecked" }}
            onClick={ _event => togglePlayEffects() }
        />
        <Button
            label={t("Speech")}
            className={if gameState.doPlaySpeech { "icon-left icon-checked" } else { "icon-left icon-unchecked" }}
            onClick={ _event => togglePlaySpeech() }
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


