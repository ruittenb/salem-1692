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

let run = (elementId: string) => {
  switch Utils.safeQuerySelector(elementId) {
  | Ok(rootElement) => ReactDOM.render(<RootPage />, rootElement)
  | Error(msg) => Utils.logError(msg)
  }
}
