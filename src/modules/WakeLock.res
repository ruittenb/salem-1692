/* *****************************************************************************
 * WakeLock
 */

open Constants

type wakeLockApi
type wakeLockSentinel

@get external wakeLock: navigator => wakeLockApi = "wakeLock"
@send external apiRequest: (wakeLockApi, string) => promise<wakeLockSentinel> = "request"
@send external apiRelease: wakeLockSentinel => unit = "release"
@get external released: wakeLockSentinel => bool = "released"

let p = "[WakeLock] "

let detectSupport = (): bool => {
  switch Js.Types.classify(navigator->wakeLock) {
  | JSObject(_) => true
  | _ => false
  }
}

let isSupported = detectSupport()

let request = (): promise<option<wakeLockSentinel>> => {
  switch isSupported {
  | false => Promise.resolve(None)
  | true =>
    navigator
    ->wakeLock
    ->apiRequest("screen")
    ->Promise.then(newSentinel => {
      Utils.logDebugPurple(p ++ "Obtained WakeLock")
      Promise.resolve(Some(newSentinel))
    })
    ->Promise.catch(error => {
      Utils.logError(p ++ "Failed to obtain WakeLock: " ++ error->Utils.getExceptionMessage)
      Promise.reject(error)
    })
  }
}

let release = (sentinel: option<wakeLockSentinel>) => {
  if sentinel != None {
    sentinel->Belt.Option.forEach(apiRelease)
    Utils.logDebugPurple(p ++ "Released WakeLock")
  }
}
