/* *****************************************************************************
 * Spacer
 */

@react.component
let make = (~verticalFill: bool=false): React.element =>
  <div className={verticalFill ? "spacer vertical-fill" : "spacer"} />
