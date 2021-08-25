
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
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (turnState, _) = React.useContext(TurnStateContext.context)

    let question = switch addressed {
        | Witch     => t("Witch, ")     ++ t("are you-FEM-SG sure?")
        | Witches   => t("Witches, ")   ++ t("are you-PL sure?")
        | Constable => t("Constable, ") ++ t("are you-MASC-SG sure?")
    }
    let choice = switch addressed {
        | Witch
        | Witches   => turnState.choiceWitches
        | Constable => turnState.choiceConstable
    }

    // This dialog hides the encompassing page in the background
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Confirm"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            { React.string(question) }
            <div />
            { React.string(choice) }
            <Spacer />
            <Spacer />
            <LargeButton className="confirm-yes" onClick=goToNextStep ></LargeButton>
            <Spacer />
            <LargeButton className="confirm-no" onClick=goToPrevStep ></LargeButton>
            <Spacer />
        </div>
    </div>
}

