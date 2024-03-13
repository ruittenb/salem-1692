/* *****************************************************************************
 * NightErrorPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (~message: string, ~goToPage): React.element => { // must have been translated
  // Construct the core element for this page
  <NightAudioPage error=true goToPage>
    <div> {React.string(message)} </div> <AudioError />
  </NightAudioPage>
}
