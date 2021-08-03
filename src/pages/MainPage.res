
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title

let initialGameState = {
    players: [],
    seatingLayout: OneAtHead,
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

    let (currentPage, goToPage)   = React.useState(_ => initialPage)
    let (gameState, setGameState) = React.useState(_ => initialGameState)
    let (turnState, setTurnState) = React.useState(_ => initialTurnState)
    let (language, setLanguage)   = React.useState(_ => initialLanguage)
    let translator                = Translator.getTranslator(language)

    let currentPage = switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage />
        | SetupPlayersForGame     => <SetupPlayersPage goToPage contineToGame=true />
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

    <LanguageContext.Provider value=(language, translator)>
        <div className=getLanguageClassName(language)>
        <GameStateContext.Provider value=(gameState, setGameState)>
            <TurnStateContext.Provider value=(turnState, setTurnState)>
                {currentPage}
            </TurnStateContext.Provider>
        </GameStateContext.Provider>
        </div>
    </LanguageContext.Provider>
}

