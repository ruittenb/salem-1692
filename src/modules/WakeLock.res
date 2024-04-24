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

let detectSupport = (): bool => {
  switch Js.Types.classify(navigator->wakeLock) {
  | JSObject(_) => true
  | _ => false
  }
}

let isSupported = detectSupport()

let request = (): promise<wakeLockSentinel> => {
  navigator
  ->wakeLock
  ->apiRequest("screen")
  ->Promise.then(newSentinel => {
    Utils.logDebug(p ++ "Obtained WakeLock")
    Promise.resolve(newSentinel)
  })
  ->Promise.catch(error => {
    Utils.logError(p ++ "Failed to obtain WakeLock: " ++ error->Utils.getExceptionMessage)
    Promise.reject(error)
  })
}

let release = (sentinel: option<wakeLockSentinel>) => {
  if sentinel != None {
    sentinel->Belt.Option.forEach(apiRelease)
    Utils.logDebug(p ++ "Released WakeLock")
  }
}
