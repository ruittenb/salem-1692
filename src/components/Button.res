
/** ****************************************************************************
 * Button
 */

@react.component
let make = (
    ~label: string,
    ~className: string = "",
    ~onClick: _ => unit = _ => ()
): React.element => {
    <button className onClick>
        {React.string(label)}
    </button>
}

