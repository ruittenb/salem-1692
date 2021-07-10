
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: language = NL_NL

let rec getCurrentPage = (
    state: state,
    setLanguage
): React.element => {
    switch state.currentPage {
        | Title          => <TitlePage />
        | Setup          => <SetupPage setLanguage />
        | SetupPlayers   => <div> {React.string("Players Placeholder")} </div>
        | Turn           => <div> {React.string("Turn Placeholder")}    </div>
        | NightWitch     => <NightPage state={state} />
        | NightConstable => <NightPage state={state} />
    }
}

@react.component
and make = (~state: state): React.element => {
    let (language, setLanguage) = React.useState(_ => initialLanguage);
    <LanguageContext.Provider value=language>
        {getCurrentPage(state, setLanguage)}
    </LanguageContext.Provider>
}

