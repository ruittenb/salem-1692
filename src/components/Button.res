
/** ****************************************************************************
 * Button
 */

open Types

@react.component
let make = (
    ~label: string,
    ~className: string = "",
    ~onClick: clickHandler,
): React.element => {
    <button className onClick>
        {React.string(label)}
    </button>
}

