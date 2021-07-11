
/** ****************************************************************************
 * Main
 *
 * ReScript            : https://rescript-lang.org/docs/manual/latest/overview
 * ReScript-React      : https://rescript-lang.org/docs/react/latest/introduction
 * ReactJS             : https://reactjs.org/docs/getting-started.html
 *
 * React               : Bindings to React
 * ReactDOM            : Bindings to the ReactDOM
 * ReactDOMServer      : Bindings to the ReactDOMServer
 * ReactEvent          : Bindings to React's synthetic events
 * ReactDOMStyle       : Bindings to the inline style API
 * RescriptReactRouter : A simple, yet fully featured router with minimal memory allocations
 */

open Types

let initialState: state = {
    currentPlayers: [
        { name: "Helmi" },
        { name: "Marco" },
        { name: "Richella" },
        { name: "Anja" },
        { name: `René` },
        { name: "Erwin" },
    ],
}

let run = (elementId: string) => {
    switch (ReactDOM.querySelector("#" ++ elementId)) {
        | Some(rootElement) => ReactDOM.render(
            <MainPage state=initialState />,
            rootElement)
        | None => ()
    }
}

