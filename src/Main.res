
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

let getCurrentPage = (state: state): React.element => {
    switch state.currentPage {
        | Title          => <TitlePage />
        | Setup          => <div> {React.string("Players")} </div>
        | SetupPlayers   => <div> {React.string("Players")} </div>
        | Turn           => <div> {React.string("Turn")}    </div>
        | NightWitch     => <NightPage phase={state.currentPage} />
        | NightConstable => <NightPage phase={state.currentPage} />
    }
}

let render = (~state: state): state => {
    let currentPageInContext =
        <Context.Locale.Provider value=state.currentLang>
            {getCurrentPage(state)}
        </Context.Locale.Provider>
    switch (ReactDOM.querySelector("#root")) {
        | Some(root) => ReactDOM.render(currentPageInContext, root)
        | None => ()
    }
    state
}

let init = (): state => {
    let currentLang = ES_ES
    {
        currentPage: Title,
        currentPlayers: [],
        currentLang,
        translator: Translator.getTranslator(currentLang)
    }
}

let run = (): state => {
    render(~state=init())
}

