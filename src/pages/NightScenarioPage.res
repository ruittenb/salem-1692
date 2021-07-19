
/** ****************************************************************************
 * NightScenarioPage
 */

open Types

@react.component
let make = (
    ~subPage: page,
    ~players: players,
    ~goToPage,
): React.element => {

    // Language and translator
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    // Audio error handler
    let (hasError, setError) = React.useState(_ => false)
    let onError = (_event): unit => setError(_ => true)

    // Scenario: getter and setter, get current step
    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let scenario: scenario = NightScenarios.getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
    let isLastStep: bool = scenarioIndex + 1 >= scenario->Belt.Array.length

    // Event handlers for stepping through scenario
    let goToPrevStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep = (_event): unit => if isLastStep {
        goToPage(_page => DaytimeReveal)
    } else {
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    // Store chosen players (killed and saved) in context
    let (witchVictimPlayer,   setWitchVictimPlayer):   (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.context1)
    let (constableSavePlayer, setConstableSavePlayer): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.context2)
    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setWitchVictimPlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setConstableSavePlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    // Construct the page
    switch (hasError, maybeScenarioStep) {
        | (true, _)                       => <NightErrorPage message=t("Unable to load audio") goToPage></NightErrorPage>
        | (false, None)                   => <NightErrorPage message=t("Index out of bounds") goToPage></NightErrorPage>
        | (false, Some(Effect(effect)))   => <NightPage goToPage><Audio track=Effect(effect) proceed=goToNextStep onError /></NightPage>
        | (false, Some(Speech(speech)))   => <NightPage goToPage><Audio track=Speech(speech) proceed=goToNextStep onError /></NightPage>
        | (false, Some(ConfirmWitch))     => <ConfirmDialogPage goToPrevStep goToNextStep address=t("Witches, ")   choice=witchVictimPlayer   />
        | (false, Some(ConfirmConstable)) => <ConfirmDialogPage goToPrevStep goToNextStep address=t("Constable, ") choice=constableSavePlayer />
        | (false, Some(ChooseWitch))      => <NightPage goToPage>
                                                <PlayerList players
                                                    choiceHandler=goFromWitchChoiceToNextStep
                                                    title=t("The witches' turn")
                                                    subtitle=t("Choose a victim:")
                                                />
                                            </NightPage>
        | (false, Some(ChooseConstable))  => <NightPage goToPage>
                                                <PlayerList players
                                                    choiceHandler=goFromConstableChoiceToNextStep
                                                    title=t("The constable's turn")
                                                    subtitle=t("Choose someone to protect:")
                                                />
                                            </NightPage>
    }
}

