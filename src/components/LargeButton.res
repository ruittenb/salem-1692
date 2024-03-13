/* *****************************************************************************
 * LargeButton
 */

open Types

@react.component
let make = (
  ~label: string="",
  ~className: string="",
  ~title: string="",
  ~children: React.element=React.null,
  ~onClick: clickHandler,
): React.element => {
  <Button label title className={className ++ " largebutton"} onClick> {children} </Button>
}
