
/** ****************************************************************************
 * Button
 */

@react.component
let make = (
    ~label: string,
    ~className: string = "",
    ~onClick: ReactEvent.Mouse.t => unit
): React.element => {
    <button className onClick>
        {React.string(label)}
    </button>
}

