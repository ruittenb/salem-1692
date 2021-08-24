
/** ****************************************************************************
 * NightScenarios
 */

open Types

let getScenario = (subPage: page): scenario => {
    switch subPage {
        | FirstNightOneWitch      => [
            PlayEffect([ ChurchBell ]),
            PlaySpeech(TownGoToSleep),
            Pause(2.0),
            PlaySpeech(WitchWakeUp),
            PlaySpeech(WitchDecideCat),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchGoToSleep),
            Pause(2.0),
            PlayEffect([ Rooster, Lark ]),
            PlaySpeech(TownWakeUp),
        ]
        | FirstNightMoreWitches   => [
            PlayEffect([ ChurchBell ]),
            PlaySpeech(TownGoToSleep),
            Pause(2.0),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideCat),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            Pause(2.0),
            PlayEffect([ Rooster, Lark ]),
            PlaySpeech(TownWakeUp),
        ]
        | OtherNightWithConstable => [
            PlayEffect([ ChurchBell ]),
            PlaySpeech(TownGoToSleep),
            Pause(2.0),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            Pause(2.0),
            PlaySpeech(ConstableWakeUp),
            ChooseConstable,
            ConfirmConstable,
            PlaySpeech(ConstableGoToSleep),
            Pause(2.0),
            PlayEffect([ Rooster, Lark ]),
            PlaySpeech(TownWakeUp),
        ]
        | OtherNightNoConstable   => [
            PlayEffect([ ChurchBell ]),
            PlaySpeech(TownGoToSleep),
            Pause(2.0),
            PlaySpeech(WitchesWakeUp),
            PlaySpeech(WitchesDecideMurder),
            ChooseWitches,
            ConfirmWitches,
            PlaySpeech(WitchesGoToSleep),
            Pause(2.0),
            PlayEffect([ Rooster, Lark ]),
            PlaySpeech(TownWakeUp),
        ]
        | _ => []
    }
}

