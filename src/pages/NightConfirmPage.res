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
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection) => {
            // clear any previous confirmation that was recorded
            FirebaseClient.saveGameConfirmation(dbConnection, gameState.gameId, subject, #Undecided)

            // install new listener
            Utils.logDebug(p ++ "About to install confirmation listener")
            FirebaseClient.listen(dbConnection, gameState.gameId, subject, (decision) => {
                switch decision {
                    | "Yes" => confirmationProcessor(#Yes)
                    | "No"  => confirmationProcessor(#No)
                    | _     => ()
                }
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection) => {
                Utils.logDebug(p ++ "About to remove confirmation listener")
                FirebaseClient.stopListening(dbConnection, gameState.gameId, subject)
            })
            Utils.logDebugRed(p ++ "Unmounted")
        })
    })

    // component
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Confirm"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
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
    </div>
}

