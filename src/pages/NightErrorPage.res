/** ****************************************************************************
 * NightErrorPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~message: string, // must have been translated
    ~goToPage,
): React.element => {

    // Construct the core element for this page
    <NightAudioPage error=true goToPage >
        <div> {React.string(message)} </div>
        <AudioError />
    </NightAudioPage>
}

