
/** ****************************************************************************
 * DaytimeConfessPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (turnState, _) = React.useContext(TurnStateContext.context)
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (constableTargetRevealed, setConstableTargetRevealed) = React.useState(_ => false)

    let constableRevealButton =
        switch turnState.choiceConstable {
            | None => React.null
            | Some(constableTargetName) =>
                <>
                    <LargeRevealButton
                        revealPrompt=t("Reveal constable's protection")
                        revelationPromptPre=t("The constable protected-PRE")
                        revelationPromptPost=t("The constable protected-POST")
                        secret=constableTargetName
                        revealed=constableTargetRevealed
                        onClick={_event => setConstableTargetRevealed(prev => !prev)}
                    />
                    <Spacer />
                </>
        }

    <div id="daytime-confess-page" className="page flex-vertical">
        <SettingsGear goToPage returnPage=DaytimeConfess />
        <h1> {React.string(t("Confess"))} </h1>
        <h2> {React.string(t("Everyone,"))} </h2>
        <div className="paragraph text-centered"> {React.string(t("decide whether you want to confess"))} </div>
        <Spacer />
        {constableRevealButton}
        <Button
            label={t("Next")}
            className="icon-right icon-forw"
            onClick={ _event => goToPage(_prev => DaytimeReveal) }
        />
    </div>
}


