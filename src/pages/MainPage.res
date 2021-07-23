
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title //  GameState
let players: Types.players = // [] // GameState
    [ "Helmi", "Marco", "Anja", "Kees", "Joyce", `René` ]

let initialTurnState = {
    nrWitches: 1,
    hasConstable: false,
    choiceWitches: "",
    choiceConstable: "",
}

let rec getCurrentPage = (
    currentPage: Types.page,
    goToPage: (Types.page => Types.page) => unit,
    setLanguage,
): React.element => {
    switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage />
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

    let (language, setLanguage)   = React.useState(_ => initialLanguage)
    let (currentPage, goToPage)   = React.useState(_ => initialPage)
    let (turnState, setTurnState) = React.useState(_ => initialTurnState)

    <LanguageContext.Provider value=language>
        <TurnStateContext.Provider value=(turnState, setTurnState)>
            {getCurrentPage(currentPage, goToPage, setLanguage)}
        </TurnStateContext.Provider>
    </LanguageContext.Provider>
}

