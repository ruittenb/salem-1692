/** ****************************************************************************
 * QR
 */

open Utils

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
@val external createQrCode: (Dom.element, qrParams) => qrCode = "createQrCode"
@send external clear: (qrCode) => unit = "clear"
@send external makeCode: (qrCode, string) => unit = "makeCode"
@get external correctLevel: (qrCodeClass) => qrCorrectLevel = "CorrectLevel"
@get external low: (qrCorrectLevel) => qrCorrectLevelLow = "L"

let p = "[QR] "

let elementId = "qr-code"
let size = "150"
let style = ReactDOM.Style.make(
    ~width = size ++ "px",
    ~height = size ++ "px",
    ()
)

let displayQrCode = (
    qrElement: Dom.element, value: string
): qrCode => {
    logDebug(p ++ "Creating QR code for " ++ value)

    let qrParams: qrParams = {
        text: value,
        width: size,
        height: size,
        correctLevel : qrCodeClass->correctLevel->low
    }
    createQrCode(qrElement, qrParams)
}

@react.component
let make = (
    ~value: string
): React.element => {

    // only after mounting the component
    React.useEffect0(() => {
        // this is a Some() when the element node is found in the DOM
        let maybeQrCode: option<qrCode> =
            switch (safeQuerySelector(elementId)) {
                | Ok(qrElement) => displayQrCode(qrElement, value)->Some
                | Error(msg)    => logError(msg)->replaceWith(None)
            }
        // cleanup: if we have the DOM node, clear it
        Some(() => maybeQrCode->Belt.Option.forEach(qrCode => qrCode->clear))
    })

    // component
    <span id={elementId} style />
}

