/* *****************************************************************************
 * HostingIcon
 */

@react.component
let make = (~masterMode: bool=false): React.element => {
  if masterMode {
    <div className="topbar-button icon-host" />
  } else {
    <> </>
  }
}
