/** ****************************************************************************
 * NightConfirmPage
 */

// @@warning("-33") // Unused 'open Types'

open Types

let p = "[NightConfirmPage] "

@react.component
let make = (
    ~addressed: addressed,
    ~confirmationProcessor,
    ~goToPrevStep,
): React.element => {

    // db connection status
    let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    // turn state
    let (turnState, _setTurnState) = React.useContext(TurnStateContext.context)
    // translator, game state
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let question = switch addressed {
        | Witch     => t("Witch, are you sure?")
        | Witches   => t("Witches, are you sure?")
        | Constable => t("Constable, are you sure?")
    }
    let choice = switch addressed {
        | Witch
        | Witches   => turnState.choiceWitches->Belt.Option.getWithDefault("")
        | Constable => turnState.choiceConstable->Belt.Option.getWithDefault("")
    }

    // Runs only once right after mounting the component
    React.useEffect0(() => {
        Utils.logDebugGreen(
            p ++ "Mounted; choiceWitches:" ++ turnState.choiceWitches->Belt.Option.getWithDefault("") ++
            " choiceConstable:" ++ turnState.choiceConstable->Belt.Option.getWithDefault("")
        )
        // At this point we should have a choice to ask confirmation for.
        // Therefore, these situations should never happen.
        switch addressed {
            | Witch     if turnState.choiceWitches   === None => goToPrevStep()
            | Witches   if turnState.choiceWitches   === None => goToPrevStep()
            | Constable if turnState.choiceConstable === None => goToPrevStep()
            | _         => ()
        }
        let subject = switch addressed {
            | Witch | Witches => {
                                     Utils.logDebug(p ++ "Clearing witches' confirmation from turn state...")
                                     Types.ConfirmWitchesSubject
                                 }
            | Constable       => {
                                     Utils.logDebug(p ++ "Clearing constable's confirmation from turn state...")
                                     Types.ConfirmConstableSubject
                                 }
        }
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            // clear any previous confirmation that was recorded
            FirebaseClient.saveGameConfirmation(dbConnection, gameId, subject, #Undecided)

            // install new listener
            Utils.logDebug(p ++ "About to install confirmation listener")
            FirebaseClient.listen(dbConnection, gameId, subject, (maybeDecision) => {
                switch maybeDecision {
                    | Some("Yes") => confirmationProcessor(#Yes)
                    | Some("No")  => confirmationProcessor(#No)
                    | Some(_)     => ()
                    | None        => ()
                }
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                Utils.logDebug(p ++ "About to remove confirmation listener")
                FirebaseClient.stopListening(dbConnection, gameId, subject)
            })
            Utils.logDebugBlue(p ++ "Unmounted")
        })
    })

    let spacing = if (turnState.nightType === Dawn) {
        <Spacer />
    } else {
        <>
            <Spacer />
            <Spacer />
            <Spacer />
        </>
    }

    // component
    <div className="night-subpage page flex-vertical">
        <h1> {React.string(t("Confirm"))} </h1>
        {spacing}
        {React.string(question)}
        <div />
        <h2> {React.string(choice)} </h2>
        <Spacer />
        <Spacer />
        <LargeButton className="confirm-yes" onClick={ (_event) => confirmationProcessor(#Yes) } ></LargeButton>
        <Spacer />
        <LargeButton className="confirm-no" onClick={ (_event) => confirmationProcessor(#No) } ></LargeButton>
        <Spacer />
    </div>
}

