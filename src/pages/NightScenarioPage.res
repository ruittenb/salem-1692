/* *****************************************************************************
 * NightScenarioPage
 */

open Types

let p = "[NightScenarioPage] "

@react.component
let make = (~subPage: page): React.element => {
  // router context
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)

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

  // What kind of night is this?
  let witchOrWitches: addressed = subPage === NightDawnOneWitch ? Witch : Witches
  let pageId: string = turnState.nightType === Dawn ? "dawn-page" : "night-page"

  // Get the current scenario step. Convert complex ones to simple ones.
  let maybeScenarioStep: option<scenarioStep> = NightScenarios.getScenarioStep(
    subPage,
    scenarioIndex,
    gameState,
  )

  // After every render: check if there is still a next scenario step
  React.useEffect(() => {
    switch (maybeScenarioStep, turnState.nightType) {
    // There are still steps in the scenario
    | (Some(_), _) => ()
    // The scenario is exhausted: find the correct next page
    | (None, Dawn) => goToPage(_page => DaytimeRevealNoConfess)
    | (None, Night) => goToPage(_page => DaytimeConfess)
    }
    None // no cleanup function
  })

  // Runs only once right after mounting the component
  React.useEffect0(() => {
    Some(
      () => {
        // Cleanup: cycle through background music tracks
        gameState.backgroundMusic
        ->Belt.Array.get(0)
        ->Belt.Option.forEach(firstTrack => {
          let newBackgroundMusic =
            gameState.backgroundMusic->Js.Array2.sliceFrom(1)->Js.Array2.concat([firstTrack])
          let newGameState = {
            ...gameState,
            backgroundMusic: newBackgroundMusic,
          }
          setGameState(_prevGameState => newGameState)
        })
      },
    )
  })

  // if we're hosting, save turn state to firebase after every change
  React.useEffect1(() => {
    Utils.logStyled(
      ~bold=true,
      ~color="black",
      p ++
      `Detected turnState change; ◇ nightType:` ++
      turnState.nightType->NightTypeCodec.toString ++
      ` ◇ numerus:` ++
      turnState.nrWitches->NumerusCodec.toString ++
      ` ◇ witches:` ++
      turnState.choiceWitches->PlayerCodec.toString ++
      ` ◇ constable:` ++
      turnState.choiceConstable->PlayerCodec.toString,
    )
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      FirebaseClient.saveGameTurnState(
        dbConnection,
        gameId,
        turnState.nightType,
        turnState.nrWitches,
        turnState.choiceWitches,
        turnState.choiceConstable,
      )
    })
    None // cleanup function
  }, [turnState])

  // if we're hosting, save game page+step (= phase) to firebase after every change
  React.useEffect1(() => {
    //let choiceWitches = turnState.choiceWitches->Belt.Option.getWithDefault("")
    //let choiceConstable = turnState.choiceConstable->Belt.Option.getWithDefault("")
    Utils.logDebug(p ++ "Detected scenarioStep change")
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      FirebaseClient.saveGamePhase(dbConnection, gameId, subPage, maybeScenarioStep)
    })
    None // cleanup function
  }, [maybeScenarioStep])

  // Event handlers for stepping through scenario
  let goToPrevStep = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
  let goToNextStep = (): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
  let onEnded = (_event): unit => goToNextStep()

  // Store chosen players (killed and saved) in context
  let goFromWitchChoiceToNextStep = (player: PlayerCodec.t, ~skipConfirmation: bool): unit => {
    Utils.logDebug(
      p ++
      "Witch choice:" ++
      player->PlayerCodec.playerTypeToLocalizedString(t) ++
      " skipConfirmation:" ++ (skipConfirmation ? "true" : "false"),
    )
    setTurnState(prevTurnState => {...prevTurnState, choiceWitches: player})
    goToNextStep() // to confirmation page

    // in Master mode, the feedback from firebase will trigger skipping confirmation
    if gameState.gameType === StandAlone && skipConfirmation {
      goToNextStep()
    }
  }
  let goFromConstableChoiceToNextStep = (player: PlayerCodec.t, ~skipConfirmation: bool): unit => {
    Utils.logDebug(
      p ++
      "Constable choice:" ++
      player->PlayerCodec.playerTypeToLocalizedString(t) ++
      " skipConfirmation:" ++ (skipConfirmation ? "true" : "false"),
    )
    setTurnState(prevTurnState => {...prevTurnState, choiceConstable: player})
    goToNextStep() // to confirmation page

    // in Master mode, the feedback from firebase will trigger skipping confirmation
    if gameState.gameType === StandAlone && skipConfirmation {
      goToNextStep()
    }
  }

  let confirmationProcessor = (confirmation: ConfirmationCodec.t): unit => {
    switch confirmation {
    | Yes => goToNextStep()
    | No => goToPrevStep()
    | Unconfirmed => ()
    }
  }

  // prepare components
  let soundImage = <img src="images/gramophone.webp" className="sound-image" />
  let soundImageGreyed = <img src="images/gramophone.webp" className="sound-image greyed" />

  let backgroundMusicElement = if gameState.doPlayMusic {
    gameState.backgroundMusic
    ->Belt.Array.get(0)
    ->Belt.Option.mapWithDefault(React.null, track => <AudioBackground track />)
  } else {
    React.null
  }

  let makeTimer = (duration: float): Js.Global.timeoutId => {
    Utils.logDebug(p ++ "Setting timer")
    Js.Global.setTimeout(() => {
      Utils.logDebug(p ++ "Timer went off")
      goToNextStep()
    }, Belt.Float.toInt(1000. *. duration))
  }

  // Construct the page
  let pageElement = switch maybeScenarioStep {
  | _ if hasError => <NightErrorPage message={t("Unable to load audio")} />
  | None => React.null // apparently always happens right before changing page

  | Some(ConditionalStep(_)) => {
      Utils.logError(p ++ "ConditionalStep should have been evaluated")
      React.null
    }
  | Some(PlayRandomEffect(_)) => {
      Utils.logError(p ++ "PlayRandomEffect should have been replaced with PlayEffect")
      React.null
    }
  | Some(Pause(duration)) =>
    <NightAudioPage goToNextStep timerId={makeTimer(duration)}> {soundImageGreyed} </NightAudioPage>

  | Some(PlayEffect(effect)) if gameState.doPlayEffects =>
    <NightAudioPage goToNextStep>
      {soundImage}
      <Audio track=Effect(effect) onEnded onError />
    </NightAudioPage>

  | Some(PlaySpeech(speech)) if gameState.doPlaySpeech =>
    <NightAudioPage goToNextStep>
      {soundImage}
      <Audio track=Speech(speech) onEnded onError />
    </NightAudioPage>

  | Some(PlayEffect(_)) => {
      goToNextStep()
      React.null
    }
  | Some(PlaySpeech(_)) => {
      goToNextStep()
      React.null
    }

  | Some(ChooseWitches) =>
    <NightChoicePage addressed=witchOrWitches choiceProcessor=goFromWitchChoiceToNextStep />
  | Some(ChooseConstable) =>
    <NightChoicePage addressed=Constable choiceProcessor=goFromConstableChoiceToNextStep />
  | Some(ConfirmWitches) =>
    <NightConfirmPage addressed=witchOrWitches confirmationProcessor goToPrevStep />
  | Some(ConfirmConstable) =>
    <NightConfirmPage addressed=Constable confirmationProcessor goToPrevStep />
  }

  // render the page
  <div id=pageId className="page">
    <WakeNode />
    {backgroundMusicElement}
    {pageElement}
  </div>
}
