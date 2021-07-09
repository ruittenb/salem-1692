
/** ****************************************************************************
 * Audio
 */

open Types

@react.component
let make = (
    ~track: track,
): React.element => {
    let directory = "audio/nl/"
    let src = directory ++ switch track {
        // do something with language FIXME
        | TownGoToSleep       => "town-go-to-sleep.mp3"
        | WitchWakeUp         => "witch-wake-up.mp3"
        | WitchesWakeUp       => "witches-wake-up.mp3"
        | WitchDecideCat      => "witch-decide-cat.mp3"
        | WitchesDecideCat    => "witches-decide-cat.mp3"
        | WitchesDecideMurder => "witches-decide-murder.mp3"
        | WitchGoToSleep      => "witch-go-to-sleep.mp3"
        | WitchesGoToSleep    => "witches-go-to-sleep.mp3"
        | ConstableWakeUp     => "constable-wake-up.mp3"
        | ConstableGoToSleep  => "constable-go-to-sleep.mp3"
        | TownWakeUp          => "town-wake-up.mp3"
    }
    <audio src>
    </audio>
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

