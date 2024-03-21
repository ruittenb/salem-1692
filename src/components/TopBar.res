/* *****************************************************************************
 * TopBar
 */

@react.component
let make = (~onBack, ~children: React.element=React.null): React.element => {
  let backArrow = switch onBack {
  | Some(handler) => <BackFloatingButton onClick={handler} />
  | None => React.null
  }

  <div id="topbar">
    <div className="topbar">
      {backArrow}
      <NetworkIcon />
      {children}
    </div>
  </div>
}