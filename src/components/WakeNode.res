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
      Utils.logDebugBlue(p ++ "request")
      WakeLock.request()
      ->Promise.then(newSentinel => {
        Js.log3("%c" ++ p ++ "obtained", "font-weight: bold; color: purple", newSentinel)
        sentinel := Some(newSentinel)
        Promise.resolve()
      })
      ->Promise.catch(error => {
        Js.log3("%c" ++ p ++ "obtained", "font-weight: bold; color: purple", error)
        sentinel := None
        Promise.reject(error)
      })
      ->ignore
    }
    // cleanup function
    Some(
      () => {
        WakeLock.release(sentinel.contents)
        sentinel := None
      },
    )
  })

  React.null
}
