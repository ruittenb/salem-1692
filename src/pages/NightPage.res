
/** ****************************************************************************
 * NightPage
 */

open Types

let elementify = _ => React.null // for converting impure (side-effect) functions to nothing

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNightOneWitch      => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchWakeUp),
            Speech(WitchDecideCat),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence2s),
            Speech(WitchGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | FirstNightMoreWitches   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideCat),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightWithConstable => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence1s),
            Speech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            Effect(Silence2s),
            Speech(ConstableGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightNoConstable   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | _                       => []
    }
}

let getPageTemplate = (
    t: string => string,
    children: React.element,
    goToPage: (page => page) => unit,
): React.element => {
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            {children}
            <Spacer />
            <Button
                label={t("Back")}
                className="icon icon_back"
                onClick={ (_event) => goToPage(_prev => Daytime) }
            />
        </div>
    </div>
}

let getErrorPage = (
    t: string => string,
    goToPage: (page => page) => unit,
): React.element => {
    getPageTemplate(
        t,
        <>
            <div> {React.string(t("ERROR while loading audio"))} </div>
            <AudioError />
        </>,
        goToPage,
    )
}

let getPage = (
    t: string => string,
    scenarioStep: scenarioStep,
    isLastStep: bool,
    players: players,
    goToPage: (page => page) => unit,
    goToScenarioIndex,
    setError,
): React.element => {

    let (witchVictimPlayer, setWitchVictimPlayer): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.context1)
    let (constableSavePlayer, setConstableSavePlayer): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.context2)

    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setWitchVictimPlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setConstableSavePlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    let onError      = (_event): unit => setError(_ => true)
    let goToPrevStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep = (_event): unit => if isLastStep {
        goToPage(_page => DaytimeReveal)
    } else {
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    let pageCoreElement = switch scenarioStep {
        | Effect(_)        => <Audio track=scenarioStep proceed=goToNextStep onError />
        | Speech(_)        => <Audio track=scenarioStep proceed=goToNextStep onError />
        | ChooseWitch      => <PlayerList
                                players
                                choiceHandler=goFromWitchChoiceToNextStep
                                title={t("The witches' turn")}
                                subtitle={t("Choose a victim:")}
                              />
        | ChooseConstable  => <PlayerList
                                players
                                choiceHandler=goFromConstableChoiceToNextStep
                                title={t("The constable's turn")}
                                subtitle={t("Choose someone to protect:")}
                              />
        | ConfirmWitch     => <ConfirmDialog
                                choice=witchVictimPlayer
                                address=t("Witches, ")
                                goToPrevStep
                                goToNextStep
                              />
        | ConfirmConstable => <ConfirmDialog
                                choice=constableSavePlayer
                                address=t("Constable, ")
                                goToPrevStep
                                goToNextStep
                              />
    }
    getPageTemplate(t, pageCoreElement, goToPage)
}

@react.component
let make = (
    ~subPage: page,
    ~players: players,
    ~goToPage,
): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let (hasError, setError)               = React.useState(_ => false)

    let scenario: scenario = getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
    let isLastStep = scenarioIndex + 1 >= scenario->Belt.Array.length

    if hasError {
        getErrorPage(t, goToPage)
    } else {
        switch maybeScenarioStep {
            | None               => React.null // should never happen
            | Some(scenarioStep) => getPage(
                t,
                scenarioStep,
                isLastStep,
                players,
                goToPage,
                goToScenarioIndex,
                setError)
        }
    }
}

