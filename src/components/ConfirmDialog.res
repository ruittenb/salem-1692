
/** ****************************************************************************
 * ConfirmDialog
 */

open Types

@react.component
let make = (
    ~choice: string,
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Confirm"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            { React.string(choice) }
            <Spacer />
            <Spacer />
            <LargeButton className="confirm_yes" onClick={ _event => goToPage(_prev => FirstNight) } >
                {React.string(t(`✔`))}
            </LargeButton>
            <Spacer />
            <LargeButton className="confirm_no" onClick={ _event => goToPage(_prev => OtherNightWithConstable) } >
                {React.string(t(`✘`))}
            </LargeButton>
            <Spacer />
        </div>
    </div>
}

