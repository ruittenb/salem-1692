
/** ****************************************************************************
 * QR
 */

@react.component
let make = (
    ~value: string
): React.element => {

    let size = "150"
    let src = "https://api.qrserver.com/v1/create-qr-code/?size=" ++ size ++ "x" ++ size ++ "&data=" ++ value
    <img src
        className="qr-code"
        width={size ++ "px"}
        height={size ++ "px"}
    />
}

