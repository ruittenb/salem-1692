
/** ****************************************************************************
 * NightScenarios
 */

open Types

let getScenario = (subPage: page): scenario => {
    // Important note: if the speech has been disabled in the configuration,
    // we must take care that no two tracks are consecutive with the same
    // sound effect (e.g. Silence2s), because if that occurs, the <audio> tag
    // is not re-rendered and therefore it does not trigger the onEnded handler.
    switch subPage {
        | FirstNightOneWitch      => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence2s),
            Speech(WitchWakeUp),
            Speech(WitchDecideCat),
            ChooseWitches,
            ConfirmWitches,
            Effect(Silence1s),
            Speech(WitchGoToSleep), // See important note above
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | FirstNightMoreWitches   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideCat),
            ChooseWitches,
            ConfirmWitches,
            Effect(Silence1s),
            Speech(WitchesGoToSleep), // See important note above
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightWithConstable => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            Effect(Silence2s),
            Speech(WitchesGoToSleep),
            Effect(Silence1s),
            Speech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            Effect(Silence1s),
            Speech(ConstableGoToSleep), // See important note above
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | OtherNightNoConstable   => [
            Effect(ChurchBell),
            Speech(TownGoToSleep),
            Effect(Silence2s),
            Speech(WitchesWakeUp),
            Speech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            Effect(Silence1s),
            Speech(WitchesGoToSleep), // See important note above
            Effect(Silence2s),
            Effect(Rooster),
            Speech(TownWakeUp),
        ]
        | _ => []
    }
}

