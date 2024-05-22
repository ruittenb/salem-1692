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

let isSupported = Type.typeof(navigator->wakeLock) === #object

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
    sentinel->Option.forEach(apiRelease)
    Utils.logDebugPurple(p ++ "Released WakeLock")
  }
}
