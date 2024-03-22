/* *****************************************************************************
 * TopBar
 */

open Types

@react.component
let make = (~onBack, ~goToPage, ~returnPage: option<page>): React.element => {
  let backArrowIcon = switch onBack {
  | Some(handler) => <BackFloatingButton onClick={handler} />
  | None => React.null
  }

  let configIcon = switch returnPage {
  | Some(page) => <GearFloatingButton goToPage returnPage=page />
  | None => React.null
  }

  <div id="topbar">
    <div className="topbar">
      {backArrowIcon}
      <NetworkIcon />
      {configIcon}
    </div>
  </div>
}
