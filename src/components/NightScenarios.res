
/** ****************************************************************************
 * NightScenarios
 */

open Types

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNightOneWitch      => [
            /*
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchWakeUp),
            Speech(WitchDecideCat),
            */
            ChooseWitches,
            ConfirmWitches,
            /*
            Effect(Silence2s),
            Speech(WitchGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
            */
        ]
        | FirstNightMoreWitches   => [
            /*
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideCat),
            */
            ChooseWitches,
            ConfirmWitches,
            /*
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
            */
        ]
        | OtherNightWithConstable => [
            /*
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            */
            ChooseWitches,
            ConfirmWitches,
            /*
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence1s),
            Speech(ConstableWakeUp),
            */
            ChooseConstable,
            ConfirmConstable,
            /*
            Effect(Silence2s),
            Speech(ConstableGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
            */
        ]
        | OtherNightNoConstable   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence1s),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | _ => []
    }
}

