
/** ****************************************************************************
 * NightScenarioPage
 */

open Types

@react.component
let make = (
    ~subPage: page,
    ~goToPage,
): React.element => {

    // Translator, game state
    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, _) = React.useContext(GameStateContext.context)

    // Audio error handler
    let (hasError, setError) = React.useState(_ => false)
    let onError = (_event): unit => setError(_ => true)

    // Scenario: getter and setter, get current step
    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let scenario: scenario = NightScenarios.getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
    let witchOrWitches: addressed = if subPage === FirstNightOneWitch { Witch } else { Witches }

    // Runs after every render
    React.useEffect(() => {
        switch maybeScenarioStep {
            | Some(_) => ()
            | None    => goToPage(_page => DaytimeConfess)
        }
        None // no cleanup function
    })

    // Event handlers for stepping through scenario
    let goToPrevStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)

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

    let backgroundMusicElement = gameState.backgroundMusic
        ->Belt.Array.get(0) // TODO pick a random one
        ->Belt.Option.mapWithDefault(
            React.null,
            track => <AudioBackground track />
        )

    // Construct the page
    let pageElement = switch (hasError, maybeScenarioStep) {
        | (true, _)                       => <NightErrorPage message=t("Unable to load audio") goToPage></NightErrorPage>
        | (false, None)                   => React.null // catch this situation in useEffect above
        | (false, Some(PlayEffect(effect)))
               if gameState.doPlayEffects => <NightStepPage goToPage>
                                                 {soundImage}
                                                 <Audio track=Effect(effect) proceed=goToNextStep onError />
                                             </NightStepPage>
        | (false, Some(PlaySpeech(speech)))
                if gameState.doPlaySpeech => <NightStepPage goToPage>
                                                 {soundImage}
                                                 <Audio track=Speech(speech) proceed=goToNextStep onError />
                                             </NightStepPage>

        | (false, Some(PlayEffect(_)))    => { goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
                                               React.null
                                             }
        | (false, Some(PlaySpeech(_)))    => { goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
                                               React.null
                                             }

        | (false, Some(ChooseWitches))    => <NightStepPage goToPage showAbortButton=false>
                                                 <PlayerList addressed=witchOrWitches choiceHandler=goFromWitchChoiceToNextStep />
                                             </NightStepPage>
        | (false, Some(ChooseConstable))  => <NightStepPage goToPage showAbortButton=false>
                                                 <PlayerList addressed=Constable  choiceHandler=goFromConstableChoiceToNextStep />
                                             </NightStepPage>

        | (false, Some(ConfirmWitches))   => <NightConfirmPage goToPrevStep goToNextStep addressed=witchOrWitches />
        | (false, Some(ConfirmConstable)) => <NightConfirmPage goToPrevStep goToNextStep addressed=Constable      />
    }

    // render the page
    <>
        {backgroundMusicElement}
        {pageElement}
    </>
}

