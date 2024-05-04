/* *****************************************************************************
 * WakeNode
 */

open WakeLock
open Constants

let p = "[WakeNode] "

@react.component
let make = (): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)

  let sentinel = ref(None)

  let obtainLock = () => {
    WakeLock.request()
    ->Promise.then(maybeNewSentinel => {
      sentinel := maybeNewSentinel
      Promise.resolve()
    })
    ->Promise.catch(error => {
      sentinel := None
      Promise.reject(error)
    })
    ->ignore
  }

  let handleVisibilityChange = () => {
    switch sentinel.contents {
    | None => ()
    | Some(s) =>
      if s->released && document->visibilityState === "visible" {
        Utils.logDebugPurple(p ++ "WakeLock was released, re-obtaining")
        obtainLock()
      }
    }
  }

  // run once after mounting
  React.useEffect0(() => {
    if !gameState.doKeepActive {
      Utils.logDebugPurple(p ++ "WakeLock not enabled")
    } else if sentinel.contents == None {
      obtainLock()
      document->addEventListener("visibilitychange", handleVisibilityChange)
    }
    // cleanup function
    Some(
      () => {
        WakeLock.release(sentinel.contents)
        // TODO test if sentinel is really released?
        sentinel := None
        document->removeEventListener("visibilitychange", handleVisibilityChange)
      },
    )
  })

  React.null
}
