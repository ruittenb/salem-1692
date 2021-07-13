
/** ****************************************************************************
 * MainPage
 */

// open Types

let initialLanguage: Types.language = NL_NL
let initialPage: Types.page = Title
let players: Types.players = // []
    [ "Helmi", "Marco", "Richella", "Anja", `René`, "Erwin" ]

let rec getCurrentPage = (
    currentPage: Types.page,
    goToPage: (Types.page => Types.page) => unit,
    setLanguage,
): React.element => {
    switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupPlayers            => <div> {React.string("Players Placeholder")} </div>
        | SetupLanguage           => <SetupLanguagePage goToPage setLanguage />
        | Credits                 => <CreditsPage goToPage />
        | Daytime                 => <DaytimePage goToPage />
        | FirstNight              => <NightPage subPage=currentPage goToPage players />
        | OtherNightNoConstable   => <NightPage subPage=currentPage goToPage players />
        | OtherNightWithConstable => <NightPage subPage=currentPage goToPage players />
        | NightWitch              => <NightPage subPage=currentPage goToPage players />
        | Exit                    => <ExitPage />
    }
}

@react.component
and make = (): React.element => {
    let (language, setLanguage) = React.useState(_ => initialLanguage);
    let (currentPage, goToPage) = React.useState(_ => initialPage);
    <LanguageContext.Provider value=language>
        {getCurrentPage(currentPage, goToPage, setLanguage)}
    </LanguageContext.Provider>
}

