
/** ****************************************************************************
 * ExitPage
 */

@react.component
let make = (): React.element => {
    <>
        %raw("window.close()") // FIXME IDW
    </>
}
