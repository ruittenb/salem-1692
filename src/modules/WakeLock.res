/* *****************************************************************************
 * WakeLock
 */

open Constants

type wakeLockApi
type wakeLockSentinel

@get external wakeLock: navigator => wakeLockApi = "wakeLock"
@send external apiRequest: (wakeLockApi, string) => promise<wakeLockSentinel> = "request"
@send external apiRelease: wakeLockSentinel => unit = "release"

let p = "[WakeLock] "
let (sentinel, setSentinel) = React.useState((_): option<wakeLockSentinel> => None)

let detectSupport = (): bool => {
  switch Js.Types.classify(navigator->wakeLock) {
  | JSObject(_) => true
  | _ => false
  }
}

let isSupported = detectSupport()

let request = async () => {
  if sentinel == None {
    try {
      let newSentinel = await navigator->wakeLock->apiRequest("screen")
      setSentinel(_ => Some(newSentinel))
      Utils.logDebug(p ++ "Obtained WakeLock")
    } catch {
    | _ => {
        setSentinel(_ => None)
        Utils.logError(p ++ "Failed to obtain WakeLock")
      }
    }
  }
}

let release = async () => {
  if sentinel != None {
    sentinel->Belt.Option.forEach(apiRelease)
    setSentinel(_ => None)
    Utils.logDebug(p ++ "Released WakeLock")
  }
}
