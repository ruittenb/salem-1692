
/** ****************************************************************************
 * SquareButton
 */

open Types

@react.component
let make = (
    ~label: string = "",
    ~className: string = "",
    ~children: React.element = React.null,
    ~onClick: clickHandler,
): React.element => {
    <Button label className={className ++ " squarebutton"} onClick>
        {children}
    </Button>
}

