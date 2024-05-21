/* *****************************************************************************
 * ServiceWorkerLoader
 */

open Constants

type navServiceWorker
type scope
type registration = {scope: scope}

@send external addEventListener: (Dom.window, string, unit => unit) => unit = "addEventListener"
@get external getServiceWorker: navigator => navServiceWorker = "serviceWorker"
@send external register: (navServiceWorker, string) => promise<registration> = "register"

let p = "[ServiceWorkerLoader] "

let queryString = Constants.debug ? "?debug=1" : ""

let maybeNavServiceWorker: option<navServiceWorker> = try {
  navigator->getServiceWorker->Some
} catch {
| _ => None
}

maybeNavServiceWorker->Option.forEach(navServiceWorker => {
  window->addEventListener("load", () => {
    navServiceWorker
    ->register("serviceworker.js" ++ queryString)
    ->Promise.then(
      (registration: registration) => {
        Js.log2(p ++ "ServiceWorker registered with scope", registration.scope)
        Promise.resolve()
      },
    )
    ->Promise.catch(
      error => {
        Js.log2(p ++ "ServiceWorker registration failed:", error)
        Promise.resolve()
      },
    )
    ->ignore
  })
})
