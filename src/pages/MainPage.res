
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
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
        | FirstNightOneWitch      => <NightScenarioPage subPage=currentPage goToPage players />
        | FirstNightMoreWitches   => <NightScenarioPage subPage=currentPage goToPage players />
        | OtherNightNoConstable   => <NightScenarioPage subPage=currentPage goToPage players />
        | OtherNightWithConstable => <NightScenarioPage subPage=currentPage goToPage players />
        | DaytimeReveal           => <div>{React.string("Daytime Reveal")} </div>
        | Close                   => <ClosePage />
    }
}

@react.component
and make = (): React.element => {

    let (language, setLanguage) = React.useState(_ => initialLanguage)
    let (currentPage, goToPage) = React.useState(_ => initialPage)
    let chosenPlayerContext1: (string, chosenPlayerSetter) = React.useState(_ => "")
    let chosenPlayerContext2: (string, chosenPlayerSetter) = React.useState(_ => "")

    <LanguageContext.Provider value=language>
        <ChosenPlayerContext.Provider1 value=chosenPlayerContext1>
        <ChosenPlayerContext.Provider2 value=chosenPlayerContext2>
            {getCurrentPage(currentPage, goToPage, setLanguage)}
        </ChosenPlayerContext.Provider2>
        </ChosenPlayerContext.Provider1>
    </LanguageContext.Provider>
}

