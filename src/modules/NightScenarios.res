
/** ****************************************************************************
 * NightScenarios
 */

open Types

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNightOneWitch      => [
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
        | FirstNightMoreWitches   => [
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
        | OtherNightWithConstable => [
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
        | OtherNightNoConstable   => [
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

