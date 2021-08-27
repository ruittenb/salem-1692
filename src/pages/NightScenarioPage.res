
/** ****************************************************************************
 * NightScenarioPage
 */

open Types
open Utils

@react.component
let make = (
    ~subPage: page,
    ~goToPage,
): React.element => {

    // Translator, game state
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // Audio error handler
    let (hasError, setError) = React.useState(_ => false)
    let onError = (_event): unit => setError(_ => true)

    // Scenario: getter and setter, get current step
    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let scenario: scenario = NightScenarios.getScenario(subPage)
    let witchOrWitches: addressed = if subPage === FirstNightOneWitch { Witch } else { Witches }

    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
        ->Belt.Option.map(step => {
            // resolve effectSets
            let resolvedStep = switch step {
                // should effectSet be empty: use default of 1s silence
                | PlayRandomEffect(effectSet) => PlayEffect(pickRandomElement(effectSet, Silence1s))
                | _                           => step
            }
            // replace silences with actual Pauses
            switch resolvedStep {
                | PlayEffect(Silence2s) => Pause(2.0)
                | PlayEffect(Silence1s) => Pause(1.0)
                | _                     => resolvedStep
            }
        })

    // After every render: check if there is still a next scenario step
    React.useEffect(() => {
        switch (maybeScenarioStep, subPage) {
            // There are still steps in the scenario
            | (Some(_), _)                  => ()
            // The scenario is exhausted: find the correct next page
            | (None, FirstNightOneWitch)
            | (None, FirstNightMoreWitches) => goToPage(_page => DaytimeRevealNoConfess)
            | (None, _)                     => goToPage(_page => DaytimeConfess)
        }
        None // no cleanup function
    })

    // Runs only once right after mounting the component
    React.useEffect0(() => {
        Some(() => { // Cleanup: cycle through background music tracks
            gameState.backgroundMusic
                ->Belt.Array.get(0)
                ->Belt.Option.forEach(firstTrack => {
                    let newBackgroundMusic = gameState.backgroundMusic
                        ->Js.Array2.sliceFrom(1)
                        ->Js.Array2.concat([ firstTrack ])
                    let newGameState = {
                        ...gameState,
                        backgroundMusic: newBackgroundMusic
                    }
                    setGameState(_prevGameState => newGameState)
                    LocalStorage.saveGameState(newGameState)
                })
        })
    })

    // Event handlers for stepping through scenario
    let goToNextStepImperative = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    let goToPrevStep     = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep     = (_event): unit => goToNextStepImperative()

    // Store chosen players (killed and saved) in context
    let (_, setTurnState) = React.useContext(TurnStateContext.context)
    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceWitches: player })
        goToNextStepImperative()
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceConstable: player })
        goToNextStepImperative()
    }

    let soundImage       = <img src="images/gramophone.png" className="sound-image" />
    let soundImageGreyed = <img src="images/gramophone.png" className="sound-image greyed" />

    let backgroundMusicElement = gameState.backgroundMusic
        ->Belt.Array.get(0)
        ->Belt.Option.mapWithDefault(
            React.null,
            track => <AudioBackground track />
        )

    // Construct the page
    let pageElement = switch (hasError, maybeScenarioStep) {
        | (true, _)                       => <NightErrorPage message=t("Unable to load audio") goToPage></NightErrorPage>
        | (false, None)                   => React.null // catch this situation in useEffect above
        | (false, Some(Pause(duration)))  => <NightStepPage goToPage goToNextStep>
                                                 { let _ = Js.Global.setTimeout(
                                                       goToNextStepImperative,
                                                       Belt.Float.toInt(1000. *. duration)
                                                   )
                                                   soundImageGreyed
                                                 }
                                             </NightStepPage>

        | (false, Some(PlayRandomEffect(_))) => Js.log("This should not happen")
                                                React.null // has been resolved above

        | (false, Some(PlayEffect(effect)))
               if gameState.doPlayEffects => <NightStepPage goToPage goToNextStep>
                                                 {soundImage}
                                                 <Audio track=Effect(effect) onEnded=goToNextStep onError />
                                             </NightStepPage>
        | (false, Some(PlaySpeech(speech)))
                if gameState.doPlaySpeech => <NightStepPage goToPage goToNextStep>
                                                 {soundImage}
                                                 <Audio track=Speech(speech) onEnded=goToNextStep onError />
                                             </NightStepPage>

        | (false, Some(PlayEffect(_)))    => { goToNextStepImperative()
                                               React.null
                                             }
        | (false, Some(PlaySpeech(_)))    => { goToNextStepImperative()
                                               React.null
                                             }

        | (false, Some(ChooseWitches))    => <NightStepPage goToPage goToNextStep showNavButtons=false>
                                                 <PlayerList addressed=witchOrWitches choiceHandler=goFromWitchChoiceToNextStep />
                                             </NightStepPage>
        | (false, Some(ChooseConstable))  => <NightStepPage goToPage goToNextStep showNavButtons=false>
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

