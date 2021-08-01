
/** ****************************************************************************
 * PlayerEntryItem
 */

open Types

@react.component
let make = (
    ~value: string,
    ~onChange: changeHandler,
    ~onRemove: clickHandler,
    ~onMove: clickHandler,
): React.element => {

    <div className="player-entry-item">
        <Button className="icon-only icon-left icon-move" onClick=onMove />
        <input type_="text" value onChange />
        <Button className="icon-only icon-right icon-trash" onClick=onRemove />
    </div>
}

