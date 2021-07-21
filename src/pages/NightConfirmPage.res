
/** ****************************************************************************
 * NightConfirmPage
 */

// @@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~addressed: addressed,
    ~choice: string,
    ~goToPrevStep,
    ~goToNextStep,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let question = switch addressed {
        | Witch     => t("Witch, ")     ++ t("are you-SG sure?")
        | Witches   => t("Witches, ")   ++ t("are you-PL sure?")
        | Constable => t("Constable, ") ++ t("are you-SG sure?")
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
            <LargeButton className="confirm_yes" onClick=goToNextStep ></LargeButton>
            <Spacer />
            <LargeButton className="confirm_no" onClick=goToPrevStep ></LargeButton>
            <Spacer />
        </div>
    </div>
}

