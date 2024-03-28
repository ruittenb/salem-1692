/* *****************************************************************************
 * NightErrorPage
 */

@@warning("-33") // Unused 'open Types'

open Types

// The message must have been translated already.
@react.component
let make = (~message: string): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  // Construct the core element for this page
  <NightAudioPage error=true>
    <div> {React.string(message)} </div>
    <AudioError />
  </NightAudioPage>
}
