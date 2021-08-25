
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title
let players: Types.players = // []
    [ "Helmi", "Marco", "Anja", "Kees", "Joyce", `René` ]

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
        | DaytimeConfess          => <DaytimeConfessPage goToPage />
        | DaytimeReveal           => <DaytimeRevealPage goToPage />
        | Close                   => <ClosePage />
    }
}

@react.component
and make = (): React.element => {

    let (language, setLanguage) = React.useState(_ => initialLanguage)
    let (currentPage, goToPage) = React.useState(_ => initialPage)
    let chosenPlayerContextWitch:     (string, chosenPlayerSetter) = React.useState(_ => "")
    let chosenPlayerContextConstable: (string, chosenPlayerSetter) = React.useState(_ => "")
    let (_, _) = React.useContext(ChosenPlayerContext.contextWitch)
    let (_, _) = React.useContext(ChosenPlayerContext.contextConstable)

    <LanguageContext.Provider value=language>
        <ChosenPlayerContext.ProviderWitch value=chosenPlayerContextWitch>
        <ChosenPlayerContext.ProviderConstable value=chosenPlayerContextConstable>
            {getCurrentPage(currentPage, goToPage, setLanguage)}
        </ChosenPlayerContext.ProviderConstable>
        </ChosenPlayerContext.ProviderWitch>
    </LanguageContext.Provider>
}

