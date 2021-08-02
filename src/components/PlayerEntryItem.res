
/** ****************************************************************************
 * PlayerEntryItem
 */

open Types

@react.component
let make = (
    ~value: string,
    ~showMoveButton: bool,
    ~showRemoveButton: bool,
    ~onRemove: clickHandler = (_) => (),
    ~onMove: clickHandler = (_) => (),
    ~onBlur: blurHandler,
): React.element => {

    let inputField = <input type_="text" defaultValue=value onBlur />

    <div className="player-entry-item">
        {
            if showMoveButton {
                <Button className="icon-only icon-left icon-move staggered" onClick=onMove />
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

