
/** ****************************************************************************
 * NightPage
 */

open Types

let elementify = _ => React.null // for converting impure (side-effect) functions to nothing

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNight              => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideCat),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence),
            Speech(WitchesGoToSleep),
            Effect(Silence),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightWithConstable => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence),
            Speech(WitchesGoToSleep),
            Speech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            Effect(Silence),
            Speech(ConstableGoToSleep),
            Effect(Silence),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightNoConstable   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitch,
            ConfirmWitch,
            Effect(Silence),
            Speech(WitchesGoToSleep),
            Effect(Silence),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | _                       => []
    }
}

let getPage = (
    goToPage: (page => page) => unit,
    goToNextStep: mediaHandler,
    scenarioStep: scenarioStep,
    players: players,
    language: language
): React.element => {
    let t = Translator.getTranslator(language)
    let pageCoreElement = switch scenarioStep {
        | ConfirmWitch     => <></> // TODO
        | ConfirmConstable => <></> // TODO
        | ChooseWitch      => <PlayerList title={t("Witches")} players />
        | ChooseConstable  => <PlayerList title={t("Constable")} players />
        | Effect(_)        => <Audio track=scenarioStep proceed=goToNextStep />
        | Speech(_)        => <Audio track=scenarioStep proceed=goToNextStep />
    }
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            <Spacer />
            <Spacer />
            {pageCoreElement}
            <Spacer />
            <Spacer />
            <Button
                label={t("Back")}
                className="icon icon_back"
                onClick={ _event => goToPage(_prev => Daytime) }
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

    let (scenarioIndex, goToScenarioIndex) = React.useState(_ => 0)
    let scenario: scenario = getScenario(subPage)
    let maybeScenarioStep: option<scenarioStep> = Belt.Array.get(scenario, scenarioIndex)
    let goToNextStep = (_event): unit => goToScenarioIndex(scenarioIndex => scenarioIndex + 1)

    switch maybeScenarioStep {
        | None               => goToPage(_prev => DaytimeReveal)->elementify
        | Some(scenarioStep) => getPage(goToPage, goToNextStep, scenarioStep, players, language)
    }
}

