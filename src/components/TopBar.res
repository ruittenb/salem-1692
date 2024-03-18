/* *****************************************************************************
 * TopBar
 */

@react.component
let make = (~children: React.element): React.element => {
  <div id="topbar">
    <div className="topbar"> {children} </div>
  </div>
}