
/** ****************************************************************************
 * MainPage
 */

// open Types

let initialLanguage: Types.language = NL_NL
let initialPage: Types.page = Title

let rec getCurrentPage = (
    state: Types.state,
    currentPage: Types.page,
    goToPage,
    setLanguage,
): React.element => {
    switch currentPage {
        | Title          => <TitlePage goToPage />
        | Setup          => <SetupPage goToPage />
        | SetupPlayers   => <div> {React.string("Players Placeholder")} </div>
        | SetupLanguage  => <SetupLanguagePage goToPage setLanguage />
        | Credits        => <CreditsPage goToPage />
        | DayTime        => <div> {React.string("DayTime Placeholder")} </div>
        | NightWitch     => <NightPage state={state} />
        | NightConstable => <NightPage state={state} />
        | Exit           => <ExitPage />
    }
}

@react.component
and make = (~state: Types.state): React.element => {
    let (language, setLanguage) = React.useState(_ => initialLanguage);
    let (currentPage, goToPage) = React.useState(_ => initialPage);
    <LanguageContext.Provider value=language>
        {getCurrentPage(state, currentPage, goToPage, setLanguage)}
    </LanguageContext.Provider>
}

