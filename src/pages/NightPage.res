
/** ****************************************************************************
 * NightPage
 */

open Types

let elementify = _ => React.null // for converting impure (side-effect) functions to nothing

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNight              => [
            Effect(ChurchBell),
            //Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            //Speech(WitchesWakeUp),
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

let getPage = (
    scenarioStep: scenarioStep,
    goToPage: (page => page) => unit,
    goToPrevStep,
    goToNextStep,
    goFromWitchChoiceToNextStep,
    goFromConstableChoiceToNextStep,
    witchVictimPlayer,
    constableSavePlayer,
    players: players,
    language: language
): React.element => {
    let t = Translator.getTranslator(language)
    let pageCoreElement = switch scenarioStep {
        | Effect(_)        => <Audio track=scenarioStep proceed=goToNextStep />
        | Speech(_)        => <Audio track=scenarioStep proceed=goToNextStep />
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
                                goToPage
                              />
        | ConfirmConstable => <ConfirmDialog
                                choice=constableSavePlayer
                                address=t("Constable, ")
                                goToPage
                              />
    }
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            <Spacer />
            <Spacer />
            <Spacer />
            {pageCoreElement}
            <Spacer />
            <Button
                label={t("Back")}
                className="icon icon_back"
                onClick={ (_event) => goToPage(_prev => Daytime) }
            />
        </div>
    </div>
}

@react.component
let make = (
    ~subPage: page,
    ~players: players,
    ~goToPage,
): React.element => {

    let language = React.useContext(LanguageContext.context)

    let (witchVictimPlayer,   setWitchVictimPlayer)   = React.useState(_ => "")
    let (constableSavePlayer, setConstableSavePlayer) = React.useState(_ => "")
    let (scenarioIndex,       goToScenarioIndex)      = React.useState(_ => 0)

    let scenario: scenario = getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)

    let goToPrevStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex - 1)
    let goToNextStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)

    let goFromWitchChoiceToNextStep = (player: player, _event): unit => {
        setWitchVictimPlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }
    let goFromConstableChoiceToNextStep = (player: player, _event): unit => {
        setConstableSavePlayer(_prev => player)
        goToScenarioIndex(scenarioIndex => scenarioIndex + 1)
    }

    switch maybeScenarioStep {
        | None               => goToPage(_prev => DaytimeReveal)->elementify
        | Some(scenarioStep) => getPage(
            scenarioStep,
            goToPage,
            goToPrevStep,
            goToNextStep,
            goFromWitchChoiceToNextStep,
            goFromConstableChoiceToNextStep,
            witchVictimPlayer,
            constableSavePlayer,
            players,
            language)
    }
}

