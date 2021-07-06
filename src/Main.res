
/** ****************************************************************************
 * Main
 *
 * React               : Bindings to React
 * ReactDOM            : Bindings to the ReactDOM
 * ReactDOMServer      : Bindings to the ReactDOMServer
 * ReactEvent          : Bindings to React's synthetic events
 * ReactDOMStyle       : Bindings to the inline style API
 * RescriptReactRouter : A simple, yet fully featured router with minimal memory allocations
 */

open Types

let init = (): state => {
    {
        currentPage: Title,
        currentLang: NL,
        currentPlayers: []
    }
}

let render = (~state: state) => {
    <div>
    {React.string("Hello, World!")}
    </div>
    /*
    switch (ReactDOM.querySelector("#root")) {
        | Some(root) => ReactDOM.render(<TitlePage name="John" />, root)
        | None => ()
    }
    */
}
