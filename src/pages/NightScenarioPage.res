
/** ****************************************************************************
 * NightScenarioPage
 */

open Types

@react.component
let make = (
    ~subPage: page,
    ~goToPage,
): React.element => {

    // connection status
    let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    // turn state
    let (turnState, setTurnState) = React.useContext(TurnStateContext.context)

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

    let resolveEffectSet = (step): scenarioStep => {
        switch step {
            // should effectSet be empty: use default of 1s silence
            | PlayRandomEffect(effectSet) => Utils.pickRandomElement(effectSet, Silence1s)->PlayEffect
            | _                           => step
        }
    }
    let resolveSilences = (step): scenarioStep => {
        switch step {
            | PlayEffect(Silence2s) => Pause(2.0)
            | PlayEffect(Silence1s) => Pause(1.0)
            | _                     => step
        }
    }

    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
        ->Belt.Option.map(resolveEffectSet)
        ->Belt.Option.map(resolveSilences)

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
                })
        })
    })

    // if we're hosting, save turn state to firebase after every change
    React.useEffect1(() => {
        FirebaseClient.ifMasterAndConnectedThenSaveGameState(dbConnectionStatus, gameState, subPage, turnState, maybeScenarioStep)
        None // cleanup function
    }, [ maybeScenarioStep ])

    // Event handlers for stepping through scenario
    let goToPrevStep  = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep  = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    let onEnded = (_event): unit => goToNextStep()

    // Store chosen players (killed and saved) in context
    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceWitches: Some(player) })
        goToNextStep()
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceConstable: Some(player) })
        goToNextStep()
    }

    let soundImage       = <img src="images/gramophone.png" className="sound-image" />
    let soundImageGreyed = <img src="images/gramophone.png" className="sound-image greyed" />

    let backgroundMusicElement = gameState.backgroundMusic
        ->Belt.Array.get(0)
        ->Belt.Option.mapWithDefault(
            React.null,
            track => <AudioBackground track />
        )

    let makeTimer = (duration: float): Js.Global.timeoutId => {
        Utils.logDebug("Setting timer")
        Js.Global.setTimeout(
            goToNextStep,
            Belt.Float.toInt(1000. *. duration)
        )
    }

    // Construct the page
    let pageElement = switch maybeScenarioStep {
        | _ if hasError                 => <NightErrorPage message=t("Unable to load audio") goToPage />
        | None                          => React.null // catch this situation in useEffect above
        | Some(Pause(duration))         => <NightStepPage goToPage goToNextStep timerId={makeTimer(duration)} >
                                               { soundImageGreyed }
                                           </NightStepPage>

        | Some(PlayRandomEffect(_))     => Utils.logDebug("This step should have been replaced with PlayEffect")
                                               React.null // has been resolved above

        | Some(PlayEffect(effect))
             if gameState.doPlayEffects => <NightStepPage goToPage goToNextStep>
                                               {soundImage}
                                               <Audio track=Effect(effect) onEnded onError />
                                           </NightStepPage>
        | Some(PlaySpeech(speech))
             if gameState.doPlaySpeech  => <NightStepPage goToPage goToNextStep>
                                               {soundImage}
                                               <Audio track=Speech(speech) onEnded onError />
                                           </NightStepPage>

        | Some(PlayEffect(_))           => {   goToNextStep()
                                               React.null
                                           }
        | Some(PlaySpeech(_))           => {   goToNextStep()
                                               React.null
                                           }

        | Some(ChooseWitches)           => <NightChoicePage>
                                               <PlayerList
                                                   addressed=witchOrWitches
                                                   choiceHandler=goFromWitchChoiceToNextStep
                                               />
                                           </NightChoicePage>
        | Some(ChooseConstable)         => <NightChoicePage>
                                               <PlayerList
                                                   addressed=Constable
                                                   choiceHandler=goFromConstableChoiceToNextStep
                                               />
                                           </NightChoicePage>

        | Some(ConfirmWitches)          => <NightConfirmPage goToPrevStep goToNextStep addressed=witchOrWitches />
        | Some(ConfirmConstable)        => <NightConfirmPage goToPrevStep goToNextStep addressed=Constable      />
    }

    // render the page
    <>
        {backgroundMusicElement}
        {pageElement}
    </>
}

