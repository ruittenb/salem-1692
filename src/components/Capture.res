/* *****************************************************************************
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
 *
 * - permissions (N.B. permissions API is not supported on Safari <= 15.4)
 *   - https://developer.mozilla.org/en-US/docs/Web/API/Navigator/permissions
 *   - https://w3c.github.io/permissions/#permissions-interface
 */

open Types
open Constants
open Utils

/* ************************************************************************
 * External functions
 */

type mediaDevices
type videoFlags = {facingMode: string}
type mediaConstraints = {video: videoFlags}
type stream
type permissions
type permissionDescriptor = {name: string}
type permissionStatus = {name: string, state: string}
type changeEvent = {target: permissionStatus}
type srcObject
type track
type canvasContext

external unsafeAsHtmlVideoElement: Dom.element => Dom.htmlVideoElement = "%identity"
external unsafeAsHtmlCanvasElement: Dom.element => Dom.htmlCanvasElement = "%identity"

// window
@send external parseQrCode: (Dom.window, string) => promise<string> = "parseQrCode"

// document
@send external createElement: (Dom.document, string) => Dom.htmlUnknownElement = "createElement"

// navigator
@get external mediaDevices: navigator => mediaDevices = "mediaDevices"
@send external getUserMedia: (mediaDevices, mediaConstraints) => promise<stream> = "getUserMedia"
@get external permissions: navigator => Js.Nullable.t<permissions> = "permissions"
@send
external permissionsQuery: (permissions, permissionDescriptor) => promise<permissionStatus> =
  "query"

@send
external addEventListener: (permissionStatus, string, changeEvent => unit) => unit =
  "addEventListener"
@send
external removeEventListener: (permissionStatus, string, changeEvent => unit) => unit =
  "removeEventListener"

// video
@send external play: Dom.htmlVideoElement => unit = "play"
@set external setSrcObject: (Dom.htmlVideoElement, stream) => unit = "srcObject"
@get external getSrcObject: Dom.htmlVideoElement => Js.Nullable.t<srcObject> = "srcObject"
@send external getTracks: srcObject => array<track> = "getTracks"
@send external stop: track => unit = "stop"

// canvas
@send external getContext: (Dom.htmlCanvasElement, string) => canvasContext = "getContext"
@send
external drawImage: (canvasContext, Dom.htmlVideoElement, int, int, int, int) => unit = "drawImage"
@send external toDataURL: (Dom.htmlCanvasElement, string) => string = "toDataURL"

/* ************************************************************************
 * Component
 */

let p = "[Capture] "

let snapInterval = 500 // milliseconds

let videoElementId = "qr-video"
let canvasElementId = "qr-canvas"

let canvasWidth = 640
let canvasHeight = 480

let mediaConstraints: mediaConstraints = {video: {facingMode: "environment"}}

let unsupportedStatus: permissionStatus = {name: "camera", state: "unsupported"}

let getCameraPermissions = (): promise<permissionStatus> => {
  switch navigator->permissions->Js.Nullable.toOption {
  | None => Js.Promise.resolve(unsupportedStatus)
  | Some(perm) => perm->permissionsQuery({name: "camera"})
  }
}

let startRecording = (maybeVideoElement: option<Dom.htmlVideoElement>, maybeGetUserMedia): bool => {
  maybeVideoElement->Option.mapOr(false, videoElement => {
    maybeGetUserMedia->Option.mapOr(false, getUserMedia => {
      getUserMedia(mediaConstraints)
      ->Promise.then(
        (stream: stream) => {
          videoElement->setSrcObject(stream)
          videoElement->play
          Promise.resolve(true)
        },
      )
      ->Promise.catch(
        _error => {
          logDebugBlue(p ++ "Unable to get camera stream")
          Promise.resolve(false)
        },
      )
      ->replaceWith(true)
    })
  })
}

// Perform document.getElementById('qr-video').srcObject.getTracks().forEach(track => track.stop())
let stopRecording = (maybeVideoElement: option<Dom.htmlVideoElement>): unit => {
  maybeVideoElement->Option.mapOr((), videoElement => {
    videoElement
    ->getSrcObject
    ->Js.Nullable.toOption
    ->Option.forEach(srcObject => {
      srcObject->getTracks->Array.forEach(stop)
    })
  })
}

let captureAndParseFrame = (maybeVideoElement, maybeCanvasElement, callback): unit => {
  (maybeVideoElement, maybeCanvasElement)
  ->Utils.optionTupleAnd
  ->Option.forEach(((videoElement, canvasElement)) => {
    canvasElement->getContext("2d")->drawImage(videoElement, 0, 0, canvasWidth, canvasHeight)
    window
    ->parseQrCode(canvasElement->toDataURL("image/png"))
    ->Promise.then(res => {
      logDebug(p ++ "parseQrCode returned: " ++ res)
      callback(res)
      Promise.resolve()
    })
    ->Promise.catch(error => {
      switch error->Js.Exn.asJsExn {
      | Some(exnValue) => Js.log2(p ++ "parseQrCode error:", exnValue->Js.Exn.message)
      | _ => Js.log2(p ++ "Unknown error:", error)
      }
      Promise.resolve()
    })
    ->ignore
  })
}

@react.component
let make = (~size: int, ~callback: string => unit): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  // Assume we're prompting for camera permission
  let (cameraAvailability, setCameraAvailability) = React.useState(_ => Prompt)

  // See if getUserMedia is available
  let maybeGetUserMedia = try {
    Some(mediaConstraints => navigator->mediaDevices->getUserMedia(mediaConstraints))
  } catch {
  | _error =>
    logError(p ++ "Cannot access camera")
    None
  }

  let permissionStateHandler = (state: string): // maybeVideoElement,
  // maybeGetUserMedia,
  unit => {
    logDebug(p ++ "camera permissions: " ++ state)
    switch state {
    | "granted" => setCameraAvailability(_prev => Granted)
    | "denied" => setCameraAvailability(_prev => Denied)
    //stopRecording(maybeVideoElement)

    | "prompt" => setCameraAvailability(_prev => Prompt)
    | "unsupported" => setCameraAvailability(_prev => Unsupported) // probably never invoked because of lack of support
    | _ => ()
    }
  }

  let permissionStatusChangeHandler = event => {
    permissionStateHandler(event.target.state) // , maybeVideoElement, maybeGetUserMedia
  }

  // only after mounting the component
  React.useEffect0(() => {
    // Canvas context object for converting the snapshot to image
    // this is a Some() when the element node is found in the DOM and the tagName is CANVAS
    let maybeCanvasElement: option<Dom.htmlCanvasElement> =
      safeQuerySelector(canvasElementId)
      ->Result.mapOr(None, x => Some(x))
      ->Option.flatMap(domNode =>
        domNode->Utils.ifTagName("CANVAS")->Option.map(unsafeAsHtmlCanvasElement)
      )

    // this is a Some() when the element node is found in the DOM and the tagName is VIDEO
    let maybeVideoElement: option<Dom.htmlVideoElement> =
      safeQuerySelector(videoElementId)
      ->Result.mapOr(None, x => Some(x))
      ->Option.flatMap(domNode =>
        domNode->Utils.ifTagName("VIDEO")->Option.map(unsafeAsHtmlVideoElement)
      )

    let _isRecording: bool = startRecording(maybeVideoElement, maybeGetUserMedia)

    // Install timer that snaps a picture at every interval
    let snapTimerId = Js.Global.setInterval(() => {
      captureAndParseFrame(maybeVideoElement, maybeCanvasElement, callback)
    }, snapInterval)

    // Find out camera recording permissions and react to a change in them.
    // JS: navigator.permissions.query({ name: 'camera' }).then(res => console.log(res.state))
    // N.B. not all browsers support the Permissions API
    let cameraPermissionsPromise =
      getCameraPermissions()
      ->Promise.then(status => {
        logDebug(p ++ "camera permissions: " ++ status.state)
        permissionStateHandler(status.state) // , maybeVideoElement, maybeGetUserMedia
        if status.state === "unsupported" {
          setCameraAvailability(_prev => Unsupported)
        } else {
          status->addEventListener("change", permissionStatusChangeHandler)
        }
        Promise.resolve(status)
      })
      ->Promise.catch(_error => {
        logDebug(p ++ "camera permissions: dismissed")
        setCameraAvailability(_prev => Dismissed)
        Promise.resolve(unsupportedStatus)
      })

    // Cleanup function
    Some(
      () => {
        Js.Global.clearInterval(snapTimerId)
        cameraPermissionsPromise
        ->Promise.then(status => {
          if status.state !== "unsupported" {
            logDebug(p ++ "Clearing permission status change handler")
            status->removeEventListener("change", permissionStatusChangeHandler)
          }
          Promise.resolve()
        })
        ->ignore
        stopRecording(maybeVideoElement)
      },
    )
  })

  let statusElement = switch cameraAvailability {
  | Denied
  | Dismissed =>
    <div className="bubble"> {React.string(t("No authorization to use the camera"))} </div>
  | Prompt =>
    <div className="bubble">
      {React.string(t("Please authorize the use of the camera to scan a QR code"))}
    </div>
  | Granted
  | Unsupported => React.null
  }

  // component
  <>
    <video id={videoElementId} width={Int.toString(size)} height="auto" autoPlay=true />
    {statusElement}
    <div id="canvas-hider">
      <canvas
        id={canvasElementId} width={Int.toString(canvasWidth)} height={Int.toString(canvasHeight)}
      />
    </div>
  </>
}
