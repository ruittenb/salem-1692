/** ****************************************************************************
 * BackFloatingButton
 */

open Types

@react.component
let make = (
    ~onClick: clickHandler,
    ~masterMode: bool = false,
): React.element => {
    let modeClass = masterMode ? "icon-host" : "icon-back"
    <div className={"floating-button floating-left " ++ modeClass} onClick ></div>
}

