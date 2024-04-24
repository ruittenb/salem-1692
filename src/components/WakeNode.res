/* *****************************************************************************
 * WakeNode
 */

open WakeLock

@react.component
let make = (): React.element => {
  let (sentinel, setSentinel) = React.useState((_): option<wakeLockSentinel> => None)

  // run once after mounting: obtain wake lock
  React.useEffect0(() => {
    Utils.logError("WakeNode: mounted")
    if sentinel == None {
      Utils.logError("WakeNode: request")
      WakeLock.request()
      ->Promise.then(newSentinel => {
        setSentinel(_ => Some(newSentinel))
        Promise.resolve()
      })
      ->Promise.catch(error => {
        setSentinel(_ => None)
        Promise.reject(error)
      })
      ->ignore
      Js.log2("WakeNode: sentinel = ", sentinel)
    }
    // cleanup function
    Some(
      () => {
        Js.log("WakeNode: cleanup/release")
        WakeLock.release(sentinel)
        setSentinel(_ => None)
      },
    )
  })

  React.null
}