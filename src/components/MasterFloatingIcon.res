/* *****************************************************************************
 * MasterFloatingIcon
 */

@react.component
let make = (~masterMode: bool=false): React.element => {
  if masterMode {
    <div className={"floating-button floating-right-down icon-host"} />
  } else {
    <> </>
  }
}
