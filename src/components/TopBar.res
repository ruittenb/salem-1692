/* *****************************************************************************
 * TopBar
 */

@react.component
let make = (~children: React.element=React.null): React.element => {
  <div id="topbar">
    <div className="topbar"> {children} </div>
  </div>
}
