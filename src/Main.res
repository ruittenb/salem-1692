
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

let initialLanguage = NL_NL

let initialState = {
    currentPage: NightWitch,
    currentPlayers: [
        { name: "Helmi" },
        { name: "Marco" },
        { name: "Richella" },
        { name: "Anja" },
        { name: `René` },
        { name: "Erwin" },
    ],
}

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

let getMain = (~state: state) => {
    <LanguageContext.Provider value=initialLanguage>
        {getCurrentPage(state)}
    </LanguageContext.Provider>
}

let run = () => {
    switch (ReactDOM.querySelector("#root")) {
        | Some(root) => ReactDOM.render(getMain(~state=initialState), root)
        | None => ()
    }
}

