
/** ****************************************************************************
 * PlayerEntryItem
 */

open Types

@react.component
let make = (
    ~value: string,
    ~onClick: clickHandler,
): React.element => {

    let readOnly = (value !== "")

    <div className="player-entry-item">
        <Button className="icon-only icon-left icon-move" onClick />
        <input type_="text" value readOnly />
        <Button className="icon-only icon-right icon-trash" onClick />
    </div>
}

