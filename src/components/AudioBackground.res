
/** ****************************************************************************
 * AudioBackground
 *
 * See also: https://html.com/attributes/audio-volume/
 */

open Types
open Constants

@react.component
let make = (
    ~track: string,
    ~volume: float = backgroundVolume
): React.element => {

    <Audio
        track=Music(track ++ ".mp3")
        volume
    />
}

