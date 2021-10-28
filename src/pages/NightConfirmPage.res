
/** ****************************************************************************
 * NightConfirmPage
 */

// @@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~addressed: addressed,
    ~goToPrevStep,
    ~goToNextStep,
): React.element => {

    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let (turnState, _) = React.useContext(TurnStateContext.context)

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
        Utils.logDebug("Mounted confirm page") // TODO
        // At this point we should have a choice to ask confirmation for.
        // Therefore, these situations should never happen.
        switch addressed {
            | Witch     if turnState.choiceWitches   === None => goToPrevStep()
            | Witches   if turnState.choiceWitches   === None => goToPrevStep()
            | Constable if turnState.choiceConstable === None => goToPrevStep()
            | _         => ()
        }
        Some(() => {
            Utils.logDebug("Unmounting Confirm page") // TODO
            () // TODO Firebase.ifMasterAndConnectedThenSaveGameState TODO is this right? Is this the slave page?
        })
    })

    // This dialog hides the encompassing page in the background
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
            <LargeButton className="confirm-yes" onClick={ (_event) => goToNextStep() } ></LargeButton>
            <Spacer />
            <LargeButton className="confirm-no" onClick={ (_event) => goToPrevStep() } ></LargeButton>
            <Spacer />
        </div>
    </div>
}

