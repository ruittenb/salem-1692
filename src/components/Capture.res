/** ****************************************************************************
 * Capture
 *
 * - take photo
 *   - https://davidwalsh.name/browser-camera
 *
 * - get image from canvas
 *   - https://stackoverflow.com/questions/10257781/
 *   - https://www.w3schools.com/tags/canvas_getimagedata.asp
 *
 * - parse QR code
 *   - https://webcodeflow.com/online-qr-code-reader/
 *   - https://github.com/sinchang/qrcode-parser
 */

open Constants
open Utils

/** **********************************************************************
 * External functions
 */

type nodeStyle
type mediaDevices
type videoFlags = { facingMode: string }
type mediaFlags = { video: videoFlags }
type srcObject
type stream
type track
type canvasContext

external unsafeAsHtmlVideoElement : Dom.element => Dom.htmlVideoElement = "%identity"
external unsafeAsHtmlCanvasElement : Dom.element => Dom.htmlCanvasElement = "%identity"

@send external createElement: (document, string) => Dom.htmlUnknownElement = "createElement"

@get external mediaDevices: (navigator) => mediaDevices = "mediaDevices"
@send external getUserMedia: (mediaDevices, mediaFlags) => Promise.t<stream> = "getUserMedia"

@send external play: (Dom.htmlVideoElement) => unit = "play"
@set external setSrcObject: (Dom.htmlVideoElement, stream) => unit = "srcObject"
@get external getSrcObject: (Dom.htmlVideoElement) => srcObject = "srcObject"
@send external getTracks: (srcObject) => array<track> = "getTracks"
@send external stop: (track) => unit = "stop"

@send external getContext: (Dom.htmlCanvasElement, string) => canvasContext = "getContext"
@send external drawImage: (canvasContext, Dom.htmlVideoElement, int, int, int, int) => unit = "drawImage"
@send external toDataURL: (Dom.htmlCanvasElement, string) => string = "toDataURL"

@send external parseQrCode: (Dom.window, string) => Promise.t<string> = "parseQrCode"

/** **********************************************************************
 * Component
 */

let p = "[Capture] "

let snapInterval = 800 // milliseconds

let videoElementId = "qr-video"
let canvasElementId = "qr-canvas"

let canvasWidth = 640
let canvasHeight = 480

let mediaFlags: mediaFlags = { video: { facingMode: "environment" } }

let startRecording = (
    maybeVideoElement: option<Dom.htmlVideoElement>,
    maybeGetUserMedia,
): bool => {
    maybeVideoElement
        ->Belt.Option.mapWithDefault(false, (videoElement) => {
            maybeGetUserMedia
                ->Belt.Option.mapWithDefault(false, (getUserMedia) => {
                    getUserMedia(mediaFlags)
                        ->Promise.then((stream: stream) => {
                            videoElement->setSrcObject(stream)
                            videoElement->play
                            Promise.resolve()
                        })
                        ->replaceWith(true)
                })
        })
}

// Perform document.getElementsById('qr-video').srcObject.getTracks()[0].stop()
let stopRecording = (
    maybeVideoElement: option<Dom.htmlVideoElement>,
): unit => {
    maybeVideoElement
        ->Belt.Option.mapWithDefault((), (videoElement) => {
            videoElement
                ->getSrcObject
                ->getTracks
                ->Belt.Array.forEach(stop)
        })
}

let captureAndParseFrame = (
    maybeVideoElement,
    maybeCanvasElement,
    callback,
): unit => {
    (maybeVideoElement, maybeCanvasElement)
        ->Utils.optionTupleAnd
        ->Belt.Option.forEach(((videoElement, canvasElement)) => {
            canvasElement
                ->getContext("2d")
                ->drawImage(
                    videoElement,
                    0, 0,
                    canvasWidth, canvasHeight
                )
            window
                ->parseQrCode(canvasElement->toDataURL("image/png"))
                ->Promise.then(res => {
                    logDebug(p ++ "parseQrCode returned: " ++ res);
                    callback(res)
                    Promise.resolve()
                })
                ->Promise.catch(error => {
                    switch error {
                        | Promise.JsError(errorObj) => Js.log2(p ++ "parseQrCode error:", errorObj->Js.Exn.message)
                        | _ => Js.log2(p ++ "Unknown error:", error)
                    }
                    Promise.resolve()
                })
                ->ignore
        })
}

@react.component
let make = (
    ~size: int,
    ~callback: (string) => unit
): React.element => {

    let sizeString = Belt.Int.toString(size)

    // See if getUserMedia is available
    let maybeGetUserMedia = try {
        Some(navigator->mediaDevices->getUserMedia)
    } catch {
        | _error =>
            logError(p ++ "Cannot access camera")
            None
    }

    // only after mounting the component
    React.useEffect0(() => {
        // Canvas context object for converting the snapshot to image
        let maybeCanvasElement: option<Dom.htmlCanvasElement> = safeQuerySelector(canvasElementId)
            ->Belt.Result.map(canvasElement => canvasElement->unsafeAsHtmlCanvasElement)
            ->Belt.Result.mapWithDefault(None, x => Some(x))

        // this is a Some() when the element node is found in the DOM
        let maybeVideoElement: option<Dom.htmlVideoElement> = safeQuerySelector(videoElementId)
            ->Belt.Result.map(videoElement => videoElement->unsafeAsHtmlVideoElement)
            ->Belt.Result.mapWithDefault(None, x => Some(x))
        let _maybeRecording: bool = startRecording(maybeVideoElement, maybeGetUserMedia)

        // Install timer that snaps a picture every 0.5 s
        let snapTimer = Js.Global.setInterval(() => {
            captureAndParseFrame(maybeVideoElement, maybeCanvasElement, callback)
        }, snapInterval)

        // Cleanup function
        Some(() => {
            Js.Global.clearInterval(snapTimer)
            stopRecording(maybeVideoElement)
        })
    })

    // component
    <>
        <video
            id={videoElementId}
            width={sizeString}
            height="auto"
            autoPlay=true
        />
        // TODO add error message if recording auth was not granted
        <div id="canvas-hider">
            <canvas
                id={canvasElementId}
                width={Belt.Int.toString(canvasWidth)}
                height={Belt.Int.toString(canvasHeight)}
            />
        </div>
    </>
}

