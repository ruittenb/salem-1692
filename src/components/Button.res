
/** ****************************************************************************
 * Button
 */

open Types

@react.component
let make = (
    ~buttonType: buttonType,
    ~label: string,
): React.element => {
    let className = "button " ++ switch buttonType {
        | RegularFirst  => "button-first"
        | RegularSecond => "button-second"
        | RegularThird  => "button-third"
    }
    <button className={className}>
        {React.string(label)}
    </button>
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

