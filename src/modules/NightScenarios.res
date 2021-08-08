
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
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayEffect(Silence2s),
            PlaySpeech(WitchWakeUp),
            PlaySpeech(WitchDecideCat),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchGoToSleep),
            PlayEffect(Silence2s),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | FirstNightMoreWitches   => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayEffect(Silence2s),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideCat),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            PlayEffect(Silence2s),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | OtherNightWithConstable => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayEffect(Silence2s),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            PlayEffect(Silence2s),
            PlaySpeech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            PlaySpeech(ConstableGoToSleep),
            PlayEffect(Silence2s),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | OtherNightNoConstable   => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayEffect(Silence2s),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            PlayEffect(Silence2s),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | _ => []
    }
}

