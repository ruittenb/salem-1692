
/** ****************************************************************************
 * Button
 */

open Types

@react.component
let make = (
    ~label: string = "",
    ~className: string = "",
    ~style: ReactDOM.Style.t = ReactDOM.Style.make(()),
    ~onClick: clickHandler,
    ~children: React.element = React.null,
): React.element => {
    <button className style onClick>
        {
            if label !== "" {
                React.string(label)
            } else {
                children
            }
        }
    </button>
}

