/** ****************************************************************************
 * Button
 */

open Types

@react.component
let make = (
    ~label: string = "",
    ~className: string = "",
    ~title: string = "",
    ~disabled: bool = false,
    ~style: ReactDOM.Style.t = ReactDOM.Style.make(()),
    ~onClick: clickHandler,
    ~children: React.element = React.null,
): React.element => {
    <button disabled className style title onClick>
        {
            if label !== "" {
                React.string(label)
            } else {
                children
            }
        }
    </button>
}

