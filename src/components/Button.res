
/** ****************************************************************************
 * Button
 */

open Types

@react.component
let make = (
    ~label: string = "",
    ~className: string = "",
    ~children: React.element = React.null,
    ~onClick: clickHandler,
): React.element => {
    <button className onClick>
        {
            if label !== "" {
                React.string(label)
            } else {
                children
            }
        }
    </button>
}

