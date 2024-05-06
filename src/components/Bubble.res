/* *****************************************************************************
 * Bubble
 */

open Types

@react.component
let make = (
  ~float: bool=false,
  ~dir: direction=Nowhere,
  ~children: React.element,
  ~clickHandler: ReactEvent.Mouse.t => unit=_ => (),
): React.element => {
  let directionClass = switch dir {
  | North => "north"
  | South => "south"
  | East => "east" // no corresponding css class yet
  | West => "west" // no corresponding css class yet
  | Nowhere => ""
  }

  let wrapperClassNames = float ? "bubble-wrapper floating" : ""
  let bubbleClassNames = "bubble " ++ (float ? "floating " : "") ++ directionClass

  <div className={wrapperClassNames} onClick={clickHandler}>
    <div className={bubbleClassNames}> {children} </div>
  </div>
}
