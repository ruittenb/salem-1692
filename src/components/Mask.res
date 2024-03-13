/* *****************************************************************************
 * Mask
 */

open Types

@react.component
let make = (~onClick: clickHandler, ~children): React.element => {
  // component
  <span id="mask" onClick> {children} </span>
}
