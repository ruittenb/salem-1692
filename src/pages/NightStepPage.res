
/** ****************************************************************************
 * NightStepPage
 *
 * One step in a Night Scenario.
 * Used by NightScenarioPage and NightErrorPage
 */

open Types

@react.component
let make = (
    ~title: string = "Night", // must not have been translated yet
    ~children: React.element,
    ~showBackButton: bool = true,
    ~goToPage,
): React.element => {

    // Language and translator
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    // Construct the core element for this page
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t(title))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            {children}
            <Spacer />
            { if showBackButton {
                <Button
                    label={t("Back")}
                    className="icon-left icon-back"
                    onClick={ (_event) => goToPage(_prev => Daytime) }
                />
            } else {
                React.null
            }}
        </div>
    </div>
}

