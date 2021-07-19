
/** ****************************************************************************
 * ConfirmDialogPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~address: string,
    ~choice: string,
    ~goToPrevStep,
    ~goToNextStep,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    // This dialog hides the encompassing page in the background
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Confirm"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            { React.string(address ++ t("are you sure?")) }
            <div />
            { React.string(choice) }
            <Spacer />
            <Spacer />
            <LargeButton className="confirm_yes" onClick=goToNextStep >
                {React.string(t(`✔`))}
            </LargeButton>
            <Spacer />
            <LargeButton className="confirm_no" onClick=goToPrevStep >
                {React.string(t(`✘`))}
            </LargeButton>
            <Spacer />
        </div>
    </div>
}

