/* *****************************************************************************
 * NightScenarios
 */

open Types

let rec getScenario = (subPage: page): scenario => {
  switch subPage {
  | NightDawnOneWitch => [
      PlayEffect(ChurchBell),
      PlaySpeech(TownStillAsleep),
      PlayRandomEffect([Silence2s, Crickets]),
      PlaySpeech(WitchWakeUp),
      PlaySpeech(WitchDecideCat),
      ChooseWitches,
      ConfirmWitches,
      PlaySpeech(WitchGoToSleep),
      Pause(2.0),
      PlayEffect(Rooster),
      PlaySpeech(TownWakeUp),
    ]
  | NightDawnMoreWitches => [
      PlayEffect(ChurchBell),
      PlaySpeech(TownStillAsleep),
      PlayRandomEffect([Silence2s, Crickets]),
      PlaySpeech(WitchesWakeUp),
      PlaySpeech(WitchesDecideCat),
      ChooseWitches,
      ConfirmWitches,
      PlaySpeech(WitchesGoToSleep),
      Pause(2.0),
      PlayEffect(Rooster),
      PlaySpeech(TownWakeUp),
    ]
  | NightOtherWithConstable => [
      PlayEffect(ChurchBell),
      PlaySpeech(TownGoToSleep),
      PlayRandomEffect([Silence2s, Crickets]),
      PlaySpeech(WitchesWakeUp),
      PlaySpeech(WitchesDecideMurder),
      ChooseWitches,
      ConfirmWitches,
      PlaySpeech(WitchesGoToSleep),
      Pause(1.0),
      PlayRandomEffect([CatMeowing, DogBarking, Footsteps, Thunderstrike]),
      Pause(1.0),
      PlaySpeech(ConstableWakeUp),
      ConditionalStep(getConstableInstructionSpeech),
      ChooseConstable,
      ConfirmConstable,
      PlaySpeech(ConstableGoToSleep),
      Pause(2.0),
      PlayEffect(Rooster),
      PlaySpeech(TownWakeUp),
    ]
  | NightOtherNoConstable => [
      PlayEffect(ChurchBell),
      PlaySpeech(TownGoToSleep),
      PlayRandomEffect([Silence2s, Crickets]),
      PlaySpeech(WitchesWakeUp),
      PlaySpeech(WitchesDecideMurder),
      ChooseWitches,
      ConfirmWitches,
      PlaySpeech(WitchesGoToSleep),
      Pause(2.0),
      PlayEffect(Rooster),
      PlaySpeech(TownWakeUp),
    ]
  | _ => []
  }
}

// If there are ghost players, the constable is also allowed to choose himself.
and getConstableInstructionSpeech = gameState =>
  if gameState.hasGhostPlayers {
    PlaySpeech(ConstableDecideAny)
  } else {
    PlaySpeech(ConstableDecideOther)
  }

// Convert complex steps to simpler ones.
let convertConditionals = (gameState, step): scenarioStep => {
  switch step {
  // If needed, use convertConditionals(getStep(gameState))
  | ConditionalStep(getStep) => getStep(gameState)
  | _ => step
  }
}
let convertEffectSet = (step): scenarioStep => {
  switch step {
  // Should effectSet be empty: use 1s of silence as default
  | PlayRandomEffect(effectSet) => Utils.pickRandomElement(effectSet, Silence1s)->PlayEffect
  | _ => step
  }
}
let convertSilences = (step): scenarioStep => {
  switch step {
  // Replace 'play silence' with actual pause. This ensures that the gramophone image is inactive
  | PlayEffect(Silence2s) => Pause(2.0)
  | PlayEffect(Silence1s) => Pause(1.0)
  | _ => step
  }
}

// Find the scenario for this dawn/night page.
// Get one scenario step (scenarioIndex) from the scenario.
// Convert complex steps to simpler ones.
let getScenarioStep = (subPage: page, scenarioIndex: int, gameState: gameState): option<
  scenarioStep,
> => {
  let scenario: scenario = getScenario(subPage)
  // Order of conversions is important here
  Belt.Array.get(scenario, scenarioIndex)
  ->Belt.Option.map(convertConditionals(gameState))
  ->Belt.Option.map(convertEffectSet)
  ->Belt.Option.map(convertSilences)
}
