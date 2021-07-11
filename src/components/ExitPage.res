
/** ****************************************************************************
 * ExitPage
 */

@@warning("-21") // Statement never returns

@react.component
let make = (): React.element => {
    %raw("window.close()")
    React.null
}
