
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: language = NL_NL
let initialPage: page = Title

let rec getCurrentPage = (
    state: state,
    language: language,
    setLanguage,
    currentPage: page,
    goToPage,
): React.element => {
    switch currentPage {
        | Title          => <TitlePage goToPage />
        | Setup          => <SetupPage goToPage setLanguage />
        | SetupPlayers   => <div> {React.string("Players Placeholder")} </div>
        | DayTime        => <div> {React.string("DayTime Placeholder")} </div>
        | NightWitch     => <NightPage state={state} />
        | NightConstable => <NightPage state={state} />
        | Exit           => <ExitPage />
    }
}

@react.component
and make = (~state: state): React.element => {
    let (language, setLanguage) = React.useState(_ => initialLanguage);
    let (currentPage, goToPage) = React.useState(_ => initialPage);
    <LanguageContext.Provider value=language>
        {getCurrentPage(state, language, setLanguage, currentPage, goToPage)}
    </LanguageContext.Provider>
}

