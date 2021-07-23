
/** ****************************************************************************
 * NightScenarioPage
 */

open Types

@react.component
let make = (
    ~subPage: page,
    ~goToPage,
): React.element => {

    // Language and translator
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    // game state
    let (gameState, _) = React.useContext(GameStateContext.context)

    // Audio error handler
    let (hasError, setError) = React.useState(_ => false)
    let onError = (_event): unit => setError(_ => true)

    // Scenario: getter and setter, get current step
    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let scenario: scenario = NightScenarios.getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
    let isLastStep: bool = scenarioIndex + 1 >= scenario->Belt.Array.length
    let witchOrWitches: addressed = if subPage === FirstNightOneWitch { Witch } else { Witches }

    // Event handlers for stepping through scenario
    let goToPrevStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep = (_event): unit => if isLastStep {
        goToPage(_page => DaytimeConfess)
    } else {
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    // Store chosen players (killed and saved) in context
    let (_, setTurnState) = React.useContext(TurnStateContext.context)
    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceWitches: player })
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceConstable: player })
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    let soundImage = <img src="images/gramophone.png" className="sound-image" />

    // Construct the page
    switch (hasError, maybeScenarioStep) {
        | (true, _)                       => <NightErrorPage message=t("Unable to load audio") goToPage></NightErrorPage>
        | (false, None)                   => <NightErrorPage message=t("Index out of bounds")  goToPage></NightErrorPage>
        | (false, Some(Effect(effect)))
               if gameState.doPlayEffects => <NightPage goToPage>{soundImage}<Audio track=Effect(effect) proceed=goToNextStep onError /></NightPage>
        | (false, Some(Speech(speech)))
               if gameState.doPlaySpeech  => <NightPage goToPage>{soundImage}<Audio track=Speech(speech) proceed=goToNextStep onError /></NightPage>
        | (false, Some(Effect(_)))
        | (false, Some(Speech(_)))        => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
                                             React.null
        | (false, Some(ConfirmWitches))   => <NightConfirmPage goToPrevStep goToNextStep addressed=witchOrWitches />
        | (false, Some(ConfirmConstable)) => <NightConfirmPage goToPrevStep goToNextStep addressed=Constable      />
        | (false, Some(ChooseWitches))    => <NightPage goToPage>
                                                <PlayerList addressed=witchOrWitches choiceHandler=goFromWitchChoiceToNextStep />
                                            </NightPage>
        | (false, Some(ChooseConstable))  => <NightPage goToPage>
                                                <PlayerList addressed=Constable  choiceHandler=goFromConstableChoiceToNextStep />
                                            </NightPage>
    }
}

