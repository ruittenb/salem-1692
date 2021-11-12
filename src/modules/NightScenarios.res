
/** ****************************************************************************
 * NightScenarios
 */

open Types

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | NightFirstOneWitch      => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayRandomEffect([ Silence2s, Crickets ]),
            PlaySpeech(WitchWakeUp),
            PlaySpeech(WitchDecideCat),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchGoToSleep),
            Pause(2.0),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | NightFirstMoreWitches   => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayRandomEffect([ Silence2s, Crickets ]),
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
            PlayRandomEffect([ Silence2s, Crickets ]),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            Pause(1.0),
            PlayRandomEffect([ CatMeowing, DogBarking, Footsteps, Thunderstrike ]),
            Pause(1.0),
            PlaySpeech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            PlaySpeech(ConstableGoToSleep),
            Pause(2.0),
            PlayEffect(Rooster),
            PlaySpeech(TownWakeUp),
        ]
        | NightOtherNoConstable   => [
            PlayEffect(ChurchBell),
            PlaySpeech(TownGoToSleep),
            PlayRandomEffect([ Silence2s, Crickets ]),
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

