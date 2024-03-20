/* *****************************************************************************
 * TopBar
 */

@react.component
let make = (~onBack, ~children: React.element=React.null): React.element => {
  <div id="topbar">
    <div className="topbar">
      <BackFloatingButton onClick={onBack} />
      <NetworkIcon />
      {children}
    </div>
  </div>
}