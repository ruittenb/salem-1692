
/** ****************************************************************************
 * SquareButton
 */

open Types

@react.component
let make = (
    ~label: string = "",
    ~className: string = "",
    ~style: ReactDOM.Style.t = ReactDOM.Style.make(()),
    ~onClick: clickHandler,
    ~children: React.element = React.null,
): React.element => {
    <Button label className={className ++ " squarebutton"} style onClick>
        {children}
    </Button>
}

