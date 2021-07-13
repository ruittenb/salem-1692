
/** ****************************************************************************
 * NightPage
 */

/*
 * var audioElement = new Audio('car_horn.wav');
 * audioElement.addEventListener('loadeddata', () => {
 *   let duration = audioElement.duration;
 *   // The duration variable now holds the duration (in seconds) of the audio clip
 * })
*/

open Types

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

@react.component
let make = (
    ~subPage: page,
    ~scenarioIndex = 0,
    ~players: players,
    ~goToPage,
): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let scenarioStep: scenarioStep = getScenario(subPage)[scenarioIndex]

    let pageCoreElement = switch scenarioStep {
        | ConfirmWitch
        | ConfirmConstable
        | ChooseWitch     => <PlayerList title={t("Witches")} players />
        | ChooseConstable => <PlayerList title={t("Constable")} players />
        | Effect(_)       => <Audio track=scenarioStep goToPage />
        | Speech(_)       => <Audio track=scenarioStep goToPage />
    }

    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            {pageCoreElement}
            <Spacer />
            <Spacer />
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

