/* *****************************************************************************
 * WakeNode
 */

open WakeLock

let p = "[WakeNode] "

@react.component
let make = (): React.element => {
  let sentinel = ref(None)

  // run once after mounting
  React.useEffect0(() => {
    // obtain wake lock
    if sentinel.contents == None {
      Utils.logDebugPurple(p ++ "requesting WakeLock")
      WakeLock.request()
      ->Promise.then(maybeNewSentinel => {
        Utils.logDebugPurple(p ++ "obtained WakeLock")
        sentinel := maybeNewSentinel
        Promise.resolve()
      })
      ->Promise.catch(error => {
        Utils.logError(p ++ "could not obtain WakeLock: " ++ error->Utils.getExceptionMessage)
        sentinel := None
        Promise.reject(error)
      })
      ->ignore
    }
    // cleanup function
    Some(
      () => {
        // TODO test if sentinel is really released
        WakeLock.release(sentinel.contents)
        sentinel := None
      },
    )
  })

  React.null
}
