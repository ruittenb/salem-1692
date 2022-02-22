/** ****************************************************************************
 * NightScenarioPage
 */

open Types

let p = "[NightScenarioPage] "

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
    let witchOrWitches: addressed = (subPage === NightFirstOneWitch) ? Witch : Witches
    let pageId: string = (turnState.nightType === Dawn) ? "dawn-page" : "night-page"

    let resolveEffectSet = (step): scenarioStep => {
        switch step {
            // should effectSet be empty: use 1s of silence as default
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
        switch (maybeScenarioStep, turnState.nightType) {
            // There are still steps in the scenario
            | (Some(_), _)                  => ()
            // The scenario is exhausted: find the correct next page
            | (None, Dawn)  => goToPage(_page => DaytimeRevealNoConfess)
            | (None, Night) => goToPage(_page => DaytimeConfess)
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
        let nightType = turnState.nightType->NightTypeCodec.nightTypeToString
        let nrWitches = turnState.nrWitches->NumerusCodec.numerusToJs
        let choiceWitches = turnState.choiceWitches->Belt.Option.getWithDefault("")
        let choiceConstable = turnState.choiceConstable->Belt.Option.getWithDefault("")
        Utils.logDebugStyled(
            p ++ "Detected turnState change; nightType:" ++ nightType ++ " witchesNumerus:" ++ nrWitches ++
            " witches:" ++ choiceWitches ++ " constable:" ++ choiceConstable,
            "font-weight: bold"
        )
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            FirebaseClient.saveGameTurnState(dbConnection, gameId, nightType, nrWitches, choiceWitches, choiceConstable)
        })
        None // cleanup function
    }, [ turnState ])

    // if we're hosting, save game page+step (= phase) to firebase after every change
    React.useEffect1(() => {
        let choiceWitches = turnState.choiceWitches->Belt.Option.getWithDefault("")
        let choiceConstable = turnState.choiceConstable->Belt.Option.getWithDefault("")
        Utils.logDebugStyled(
            p ++ "Detected scenarioStep change; witches:" ++ choiceWitches ++ " constable:" ++ choiceConstable,
            "font-weight: bold"
        )
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            FirebaseClient.saveGamePhase(dbConnection, gameId, subPage, maybeScenarioStep)
        })
        None // cleanup function
    }, [ maybeScenarioStep ])

    // Event handlers for stepping through scenario
    let goToPrevStep  = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep  = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    let onEnded = (_event): unit => goToNextStep()

    // Store chosen players (killed and saved) in context
    let goFromWitchChoiceToNextStep = (player: player): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceWitches: Some(player) })
        goToNextStep()
    }
    let goFromConstableChoiceToNextStep = (player: player): unit => {
        setTurnState(prevTurnState => { ...prevTurnState, choiceConstable: Some(player) })
        goToNextStep()
    }

    let continueFromWitchDecision = (decision: DecisionCodec.t): unit => {
        switch decision {
            | #Yes       => goToNextStep()
            | #No        => goToPrevStep()
            | #Undecided => ()
        }
    }
    let continueFromConstableDecision = (decision: DecisionCodec.t): unit => {
        switch decision {
            | #Yes       => goToNextStep()
            | #No        => goToPrevStep()
            | #Undecided => ()
        }
    }

    // prepare components
    let soundImage       = <img src="images/gramophone.webp" className="sound-image" />
    let soundImageGreyed = <img src="images/gramophone.webp" className="sound-image greyed" />

    let backgroundMusicElement = if gameState.doPlayMusic {
        gameState.backgroundMusic
            ->Belt.Array.get(0)
            ->Belt.Option.mapWithDefault(
                React.null,
                track => <AudioBackground track />
            )
    } else {
        React.null
    }

    let makeTimer = (duration: float): Js.Global.timeoutId => {
        Utils.logDebug(p ++ "Setting timer")
        Js.Global.setTimeout(
            () => {
                Utils.logDebug(p ++ "Timer went off")
                goToNextStep()
            },
            Belt.Float.toInt(1000. *. duration)
        )
    }

    // Construct the page
    let pageElement = switch maybeScenarioStep {
        | _ if hasError                 => <NightErrorPage message=t("Unable to load audio") goToPage />
        | None                          => React.null // catch this situation in useEffect above
        | Some(Pause(duration))         => <NightAudioPage goToPage goToNextStep timerId={makeTimer(duration)} >
                                               {soundImageGreyed}
                                           </NightAudioPage>

        | Some(PlayRandomEffect(_))     => {   Utils.logDebug(p ++ "This step should have been replaced with PlayEffect")
                                               React.null // has been resolved above
                                           }
        | Some(PlayEffect(effect))
             if gameState.doPlayEffects => <NightAudioPage goToPage goToNextStep>
                                               {soundImage}
                                               <Audio track=Effect(effect) onEnded onError />
                                           </NightAudioPage>
        | Some(PlaySpeech(speech))
             if gameState.doPlaySpeech  => <NightAudioPage goToPage goToNextStep>
                                               {soundImage}
                                               <Audio track=Speech(speech) onEnded onError />
                                           </NightAudioPage>

        | Some(PlayEffect(_))           => {   goToNextStep()
                                               React.null
                                           }
        | Some(PlaySpeech(_))           => {   goToNextStep()
                                               React.null
                                           }

        | Some(ChooseWitches)           => <NightChoicePage
                                               addressed=witchOrWitches
                                               choiceProcessor=goFromWitchChoiceToNextStep
                                           />
        | Some(ChooseConstable)         => <NightChoicePage
                                               addressed=Constable
                                               choiceProcessor=goFromConstableChoiceToNextStep
                                           />
        | Some(ConfirmWitches)          => <NightConfirmPage
                                               addressed=witchOrWitches
                                               confirmationProcessor=continueFromWitchDecision
                                               goToPrevStep
                                           />
        | Some(ConfirmConstable)        => <NightConfirmPage
                                               addressed=Constable
                                               confirmationProcessor=continueFromConstableDecision
                                               goToPrevStep
                                           />
    }

    // render the page
    <div id=pageId className="page">
        {backgroundMusicElement}
        {pageElement}
    </div>
}

