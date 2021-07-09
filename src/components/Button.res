
/** ****************************************************************************
 * Button
 */

@react.component
let make = (
    ~label: string,
    ~className: string="",
): React.element => {
    <button className>
        {React.string(label)}
    </button>
}

