
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title //  GameState

let initialGameState = {
    players: [ "Helmi", "Marco", "Anja", "Kees", "Joyce", `René`, "Rodney", "Erwin", "Wendy", "Paul", "Laurent" ],
    seatingLayout: TwoAtHead,
    doPlayEffects: true,
    doPlaySpeech: true,
}
let initialTurnState = {
    nrWitches: 1,
    hasConstable: false,
    choiceWitches: "",
    choiceConstable: "",
}

let getLanguageClassName = (language: language): string => {
    switch language {
        | EN_US => "en_US"
        | NL_NL => "nl_NL"
        | ES_ES => "es_ES"
    }
}

@react.component
let make = (): React.element => {

    let (language, setLanguage)   = React.useState(_ => initialLanguage)
    let (currentPage, goToPage)   = React.useState(_ => initialPage)
    let (gameState, setGameState) = React.useState(_ => initialGameState)
    let (turnState, setTurnState) = React.useState(_ => initialTurnState)

    let currentPage = switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage />
        | SetupLanguage           => <SetupLanguagePage goToPage setLanguage />
        | Credits                 => <CreditsPage goToPage />
        | Daytime                 => <DaytimePage goToPage />
        | FirstNightOneWitch      => <NightScenarioPage goToPage subPage=currentPage />
        | FirstNightMoreWitches   => <NightScenarioPage goToPage subPage=currentPage />
        | OtherNightNoConstable   => <NightScenarioPage goToPage subPage=currentPage />
        | OtherNightWithConstable => <NightScenarioPage goToPage subPage=currentPage />
        | DaytimeConfess          => <DaytimeConfessPage goToPage />
        | DaytimeReveal           => <DaytimeRevealPage goToPage />
        | Close                   => <ClosePage />
    }

    <LanguageContext.Provider value=language>
        <div className=getLanguageClassName(language)>
        <GameStateContext.Provider value=(gameState, setGameState)>
            <TurnStateContext.Provider value=(turnState, setTurnState)>
                {currentPage}
            </TurnStateContext.Provider>
        </GameStateContext.Provider>
        </div>
    </LanguageContext.Provider>
}

