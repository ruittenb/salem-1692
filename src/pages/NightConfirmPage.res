
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
        | Witch     => t("Witch, ")     ++ t("are you-FEM-SG sure?")
        | Witches   => t("Witches, ")   ++ t("are you-PL sure?")
        | Constable => t("Constable, ") ++ t("are you-MASC-SG sure?")
    }
    let choice = switch addressed {
        | Witch
        | Witches   => turnState.choiceWitches->Belt.Option.getWithDefault("")
        | Constable => turnState.choiceConstable->Belt.Option.getWithDefault("") // choice cannot be None here
    }

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
            <LargeButton className="confirm-yes" onClick=goToNextStep ></LargeButton>
            <Spacer />
            <LargeButton className="confirm-no" onClick=goToPrevStep ></LargeButton>
            <Spacer />
        </div>
    </div>
}

