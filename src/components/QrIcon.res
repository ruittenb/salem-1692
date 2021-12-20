/** ****************************************************************************
 * QrIcon
 */

open Types

type mode =
    | Scannable(string)
    | Scanner(string => unit)

@react.component
let make = (
    ~mode: mode,
): React.element => {

    let (maskOpen, setMaskOpen) = React.useState(_ => false)

    let openMask: clickHandler = (_event): unit => {
        setMaskOpen(_prev => true)
    }
    let closeMask: clickHandler = (_event): unit => {
        setMaskOpen(_prev => false)
    }

    // composing elements
    let icon = switch (mode) {
        | Scannable(_) => <img src="images/qr-icon-32.png" className="qr-icon scannable" onClick=openMask />
        | Scanner(_)   => <img src="images/qr-icon-44x36s.png" className="qr-icon" onClick=openMask />
    }
    let mask = if (maskOpen) {
        <Mask onClick=closeMask>
            {
                switch (mode) {
                    | Scannable(value) => <QR value />
                    | Scanner(callback) => <Capture size=250 callback />
                }
            }
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

