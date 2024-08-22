/* *****************************************************************************
 * PlayerFormLine
 */

open Types

@react.component
let make = (
  ~value: string,
  ~placeholder: string="",
  ~role: string="",
  ~className: string="",
  ~showSwapButton: bool,
  ~showRemoveButton: bool,
  ~onRemove: clickHandler=_ => (),
  ~onSwap: clickHandler=_ => (),
  ~onBlur: blurHandler=_ => (),
  ~onChange: changeHandler=_ => (),
): React.element => {
  let inputField = <input type_="text" defaultValue=value placeholder className onBlur onChange />

  <div className="player-entry-item" role>
    {if showSwapButton {
      <Button className="smallsquarebutton icon-left icon-move staggered" onClick=onSwap />
    } else {
      <div className="button-sized staggered" />
    }}
    {inputField}
    {if showRemoveButton {
      <Button className="smallsquarebutton icon-right icon-trash" onClick=onRemove />
    } else {
      <div className="button-sized" />
    }}
  </div>
}
