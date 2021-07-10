
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

let initialLanguage = NL_NL

let getCurrentPage = (state: state): React.element => {
    switch state.currentPage {
        | Title          => <TitlePage />
        | Setup          => <SetupPage />
        | SetupPlayers   => <div> {React.string("Players")} </div>
        | Turn           => <div> {React.string("Turn")}    </div>
        | NightWitch     => <NightPage state={state} />
        | NightConstable => <NightPage state={state} />
    }
}

let render = (~state: state): state => {
    let currentPageInContext =
        <LanguageContext.Provider value=initialLanguage>
            {getCurrentPage(state)}
        </LanguageContext.Provider>
    switch (ReactDOM.querySelector("#root")) {
        | Some(root) => ReactDOM.render(currentPageInContext, root)
        | None => ()
    }
    state
}

let init = (): state => {
    {
        currentPage: Setup,
        currentPlayers: [
            { name: "Helmi" },
            { name: "Marco" },
            { name: "Richella" },
            { name: "Anja" },
            { name: `René` },
            { name: "Erwin" },
        ],
    }
}

let run = (): state => {
    render(~state=init())
}

