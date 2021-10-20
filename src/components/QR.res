
/** ****************************************************************************
 * QR
 */

type qrCodeClass
type qrCode
type qrCorrectLevel
type qrCorrectLevelLow
type qrParams = {
    text: string,
    width: string,
    height: string,
    correctLevel: qrCorrectLevelLow
}

@val external qrCodeClass: qrCodeClass = "QRCode"
@val external getQrCode: (Dom.element, qrParams) => qrCode = "getQrCode"
@send external makeCode: (qrCode, string) => unit = "makeCode"
@get external correctLevel: (qrCodeClass) => qrCorrectLevel = "CorrectLevel"
@get external low: (qrCorrectLevel) => qrCorrectLevelLow = "L"

@react.component
let make = (
    ~value: string
): React.element => {

    let elementId = "qr-code"
    let size = "150"
    let style=ReactDOM.Style.make(
        ~width = size ++ "px",
        ~height = size ++ "px",
        ()
    )

    let displayQrCode = (qrElement) => {
        let qrParams: qrParams = {
            text: value,
            width: size,
            height: size,
            correctLevel : qrCodeClass->correctLevel->low
        }
        let qrCode = getQrCode(qrElement, qrParams)
        qrCode->makeCode(value)
    }

    React.useEffect(() => {
        switch (Utils.safeQuerySelector(elementId)) {
            | Ok(qrElement) => displayQrCode(qrElement)
            | Error(msg) => Utils.logError(msg)
        }
        None
    })

    // component
    <div id={elementId} style={style} />
}

