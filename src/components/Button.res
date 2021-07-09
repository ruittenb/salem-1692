
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

// vim: set ts=4 sw=4 et list nu fdm=marker:

