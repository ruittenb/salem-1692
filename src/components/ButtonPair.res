/* *****************************************************************************
 * ButtonPair
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (~children: React.element=React.null): React.element => {
  <div className="buttonpair"> {children} </div>
}
