/** ****************************************************************************
 * PlayerFormLine
 */

open Types

@react.component
let make = (
    ~value: string,
    ~placeholder: string = "",
    ~showSwapButton: bool,
    ~showRemoveButton: bool,
    ~onRemove: clickHandler = (_) => (),
    ~onSwap: clickHandler = (_) => (),
    ~onBlur: blurHandler = (_) => (),
    ~onChange: changeHandler = (_) => (),
): React.element => {

    let inputField = <input type_="text" defaultValue=value placeholder onBlur onChange />

    <div className="player-entry-item">
        {
            if showSwapButton {
                <Button className="icon-only icon-left icon-move staggered" onClick=onSwap />
            } else {
                <div className="button-sized" />
            }
        }
        {inputField}
        {
            if showRemoveButton {
                <Button className="icon-only icon-right icon-trash" onClick=onRemove />
            } else {
                <div className="button-sized" />
            }
        }
    </div>
}

