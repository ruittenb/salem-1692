
/** ****************************************************************************
 * Button
 */

@react.component
let make = (
    ~className: string = "",
    ~onClick: ReactEvent.Mouse.t => unit,
    ~children: React.element,
): React.element => {
    <button className={className ++ " largebutton"} onClick>
        {children}
    </button>
}

