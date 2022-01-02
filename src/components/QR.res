/** ****************************************************************************
 * QR
 */

open Utils

type qrCodeClass
type qrCode
type qrCorrectLevel
type qrCorrectLevelMedium
type qrParams = {
    text: string,
    width: string,
    height: string,
    correctLevel: qrCorrectLevelMedium
}

@val external qrCodeClass: qrCodeClass = "QRCode"
@val external createQrCode: (Dom.element, qrParams) => qrCode = "createQrCode"
@send external clear: (qrCode) => unit = "clear"
@send external makeCode: (qrCode, string) => unit = "makeCode"
@get external correctLevel: (qrCodeClass) => qrCorrectLevel = "CorrectLevel"
@get external medium: (qrCorrectLevel) => qrCorrectLevelMedium = "M"

let p = "[QR] "

let elementId = "qr-code"

let displayQrCode = (
    qrElement: Dom.element,
    size: string,
    value: string,
): qrCode => {
    logDebug(p ++ "Creating QR code for " ++ value)

    let qrParams: qrParams = {
        text: value,
        width: size,
        height: size,
        correctLevel : qrCodeClass->correctLevel->medium
    }
    createQrCode(qrElement, qrParams)
}

@react.component
let make = (
    ~value: string,
    ~size: int = 175,
): React.element => {

    let sizeString = Belt.Int.toString(size)
    let style = ReactDOM.Style.make(
        ~width  = sizeString ++ "px",
        ~height = sizeString ++ "px",
        ()
    )

    // only after mounting the component
    React.useEffect0(() => {
        // this is a Some() when the element node is found in the DOM
        let maybeQrCode: option<qrCode> =
            switch (safeQuerySelector(elementId)) {
                | Ok(qrElement) => displayQrCode(qrElement, sizeString, value)->Some
                | Error(msg)    => logError(msg)->replaceWith(None)
            }
        // cleanup: if we have the DOM node, clear it
        Some(() => maybeQrCode->Belt.Option.forEach(qrCode => qrCode->clear))
    })

    // component
    <span id={elementId} style />
}

