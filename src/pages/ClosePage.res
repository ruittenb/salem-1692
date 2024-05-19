/* *****************************************************************************
 * ClosePage
 */

open Constants

@send external close: Dom.window => unit = "close"

@react.component
let make = (): React.element => {
  // While running on desktop this will likely give the error:
  // Scripts may close only the windows that were opened by them.
  window->close
  <br />
}