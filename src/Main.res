/* *****************************************************************************
 * Main
 *
 * React               : Bindings to React
 * ReactDOM            : Bindings to the ReactDOM
 * ReactDOMServer      : Bindings to the ReactDOMServer
 * ReactEvent          : Bindings to React's synthetic events
 * ReactDOMStyle       : Bindings to the inline style API
 * RescriptReactRouter : A simple, yet fully featured router
 */

//external createRoot: Dom.element => ReactDOM.Client.Root.t = "createRoot"

@module("react-dom/client")
let run = (elementId: string) => {
  switch Utils.safeQuerySelector(elementId) {
  | Ok(rootElement) => {
      let root = ReactDOM.Client.createRoot(rootElement)
      ReactDOM.Client.Root.render(root, <Router />)
    }
  | Error(msg) => Utils.logError(msg)
  }
}
