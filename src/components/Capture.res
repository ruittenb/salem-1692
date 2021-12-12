/** ****************************************************************************
 * Capture
 *
 * - take photo
 *   - https://davidwalsh.name/browser-camera
 *
 * - get image from canvas
 *   - https://stackoverflow.com/questions/10257781/can-i-get-image-from-canvas-element-and-use-it-in-img-src-tag
 *   - https://www.w3schools.com/tags/canvas_getimagedata.asp
 *
 * - parse QR code
 *   - https://webcodeflow.com/online-qr-code-reader/
 */

open Constants
open Utils

type mediaDevices
type mediaFlags = { video: bool }
type srcObject
type stream
type track
type canvasContext

external unsafeAsHtmlCanvasElement : Dom.element => Dom.htmlCanvasElement = "%identity"
external unsafeAsHtmlVideoElement : Dom.element => Dom.htmlVideoElement = "%identity"

@send external createElement: (document, string) => Dom.htmlUnknownElement = "createElement"

@get external mediaDevices: (navigator) => mediaDevices = "mediaDevices"
@send external getUserMedia: (mediaDevices, mediaFlags) => Js.Promise.t<stream> = "getUserMedia"

@send external play: (Dom.htmlVideoElement) => unit = "play"
@set external setSrcObject: (Dom.htmlVideoElement, stream) => unit = "srcObject"
@get external getSrcObject: (Dom.htmlVideoElement) => srcObject = "srcObject"
@send external getTracks: (srcObject) => array<track> = "getTracks"
@send external stop: (track) => unit = "stop"

// @set external setWidth: (Dom.htmlCanvasElement, int) => unit = "width"
// @set external setHeight: (Dom.htmlCanvasElement, int) => unit = "height"
@send external getContext: (Dom.htmlCanvasElement, string) => canvasContext = "getContext"

@send external qrCodeParser: (string) => Promise.t<unit> = "qrCodeParser"

let p = "[Capture] "

let videoElementId = "qr-video"
let canvasElementId = "qr-canvas"

@react.component
let make = (
    ~size: int,
    ~callback: (string) => unit
): React.element => {

    let sizeString = size->Belt.Int.toString

    // See if getUserMedia is available
    let maybeGetUserMedia = try {
        Some(navigator->mediaDevices->getUserMedia)
    } catch {
        | _error =>
            logError(p ++ "Cannot access camera")
            None
    }

    let mediaFlags: mediaFlags = { video: true }
    let startRecording = (videoElement: Dom.htmlVideoElement): bool => {
        switch (maybeGetUserMedia) {
            | None               => false
            | Some(getUserMedia) => getUserMedia(mediaFlags)
                                        ->Promise.then((stream: stream) => {
                                            videoElement->setSrcObject(stream)
                                            videoElement->play
                                            Promise.resolve()
                                        })
                                        ->replaceWith(true)
        }
    }
    // Perform document.getElementsByTagName('video')[0].srcObject.getTracks()[0].stop()
    let stopRecording = (maybeVideoElement): unit => {
        switch (maybeVideoElement) {
            | None               => ()
            | Some(videoElement) => videoElement
                                        ->getSrcObject
                                        ->getTracks
                                        ->Belt.Array.forEach(stop)
        }
    }

    // only after mounting the component
    React.useEffect0(() => {
        // Canvas context object for converting the snapshot to image
        let maybeCanvasElement: option<Dom.htmlCanvasElement> = safeQuerySelector(canvasElementId)
            ->Belt.Result.map(canvasElement => canvasElement->unsafeAsHtmlCanvasElement)
            ->Belt.Result.mapWithDefault(None, x => Some(x))
        let _maybeCanvasContext: option<canvasContext> =
            maybeCanvasElement
                ->Belt.Option.map(canvasElement => canvasElement->getContext("2d"))

        // this is a Some() when the element node is found in the DOM
        let maybeVideoElement: option<Dom.htmlVideoElement> = safeQuerySelector(videoElementId)
            ->Belt.Result.map(videoElement => videoElement->unsafeAsHtmlVideoElement)
            ->Belt.Result.mapWithDefault(None, x => Some(x))
        let _maybeRecording: bool =
            maybeVideoElement
                ->Belt.Option.mapWithDefault(false, startRecording)

        // Cleanup function
        Some(() => stopRecording(maybeVideoElement))
    })

    // component
    <>
        <video
            id={videoElementId}
            width={sizeString}
            height={sizeString}
            // autoPlay=true
        />
        <div id="canvas-hider">
            <canvas
                id={canvasElementId}
                width={sizeString}
                height={sizeString}
            />
        </div>
    </>
}

