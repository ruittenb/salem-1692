
/** ****************************************************************************
 * DaytimeConfessPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (dbConnectionStatus, _) = React.useContext(DbConnectionContext.context)
    let (turnState, _)          = React.useContext(TurnStateContext.context)
    let (gameState, _)          = React.useContext(GameStateContext.context)
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

    // Runs only once right after mounting the component
    React.useEffect0(() => {
        FirebaseClient.ifMasterAndConnectedThenSaveGameState(
            dbConnectionStatus, gameState, DaytimeConfess, Constants.initialTurnState, None
        )
        None // cleanup
    })

    <div id="daytime-confess-page" className="page flex-vertical">
        <GearFloatingButton goToPage returnPage=DaytimeConfess />
        <h1> {React.string(t("Confess"))} </h1>
        <h2> {React.string(t("Everyone,"))} </h2>
        <p> {React.string(t("decide whether you want to confess"))} </p>
        <Spacer />
        {constableRevealButton}
        <Button
            label={t("Next")}
            className="icon-right icon-forw"
            onClick={ _event => goToPage(_prev => DaytimeReveal) }
        />
    </div>
}


