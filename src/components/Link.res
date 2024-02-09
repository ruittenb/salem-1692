/* *****************************************************************************
 * Link
 */

@react.component
let make = (
  ~href: string,
  ~text: string="",
  ~children=React.null
): React.element => {
  <a href rel="noreferrer"> {text === "" ? children : React.string(text)} </a>
}
