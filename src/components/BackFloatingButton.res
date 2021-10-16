
/** ****************************************************************************
 * BackFloatingButton
 */

open Types

@react.component
let make = (
    ~onClick: clickHandler
): React.element => {

    <div className="floating-button floating-left icon-back" onClick ></div>
}

