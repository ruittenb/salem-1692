/** ****************************************************************************
 * QrIcon
 */

open Types

@react.component
let make = (
    ~value: string
): React.element => {

    let (maskOpen, setMaskOpen) = React.useState(_ => false)

    let openMask: clickHandler = (_event): unit => {
        setMaskOpen(_prev => true)
    }
    let closeMask: clickHandler = (_event): unit => {
        setMaskOpen(_prev => false)
    }

    // composing elements
    let icon = <img src="images/qr-icon-32.png" className="qr-icon" onClick=openMask />
    let mask = if (maskOpen) {
        <Mask onClick=closeMask>
            <QR value />
        </Mask>
    } else {
        React.null
    }

    // main component
    <>
        {icon}
        {mask}
    </>
}

