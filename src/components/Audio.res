
/** ****************************************************************************
 * Audio
 */

open Types

@react.component
let make = (
    ~track: track,
): React.element => {
    let src = switch track {
        // do something with language FIXME
        | A_TownGoSleep      => "tracks/a.mp3"
        | B_WitchWakeUp      => "tracks/b.mp3"
        | E_WitchGoSleep     => "tracks/e.mp3"
        | G_WitchesWakeUp    => "tracks/g.mp3"
        | J_WitchesGoSleep   => "tracks/j.mp3"
        | M_ConstableWakeUp  => "tracks/m.mp3"
        | N_ConstableGoSleep => "tracks/n.mp3"
        | Z_TownWakeUp       => "tracks/z.mp3"
    }
    <audio src>
    </audio>
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

