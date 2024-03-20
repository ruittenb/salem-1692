/* *****************************************************************************
 * BackFloatingButton
 */

open Types

@react.component
let make = (~onClick: clickHandler): React.element => {
  <div className="topbar-button icon-back" onClick />
}
