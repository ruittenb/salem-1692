
/** ****************************************************************************
 * MainPage
 */

open Types

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title

let initialGameState = {
    players: [],
    seating: #OneAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: [],
}
let initialTurnState = {
    nrWitches: 1,
    hasConstable: false,
    choiceWitches: "",
    choiceConstable: "",
}

let getLanguageClassName = (language: language): string => {
    Translator.getLanguageCode(language)
}

let loadGameStateFromLocalStorage = (setGameState): unit => {
    LocalStorage.loadGameStateFromLocalStorage()
        ->Belt.Option.forEach(
            gameState => setGameState(_prev => gameState)
        )
}

@react.component
let make = (): React.element => {

    let (currentPage, goToPage)   = React.useState(_ => initialPage)
    let (gameState, setGameState) = React.useState(_ => initialGameState)
    let (turnState, setTurnState) = React.useState(_ => initialTurnState)
    let (language,  setLanguage)  = React.useState(_ => initialLanguage)
    let translator                = Translator.getTranslator(language)

    // run once after mounting
    React.useEffect0(() => {
        loadGameStateFromLocalStorage(setGameState)
        None // cleanup function
    })

    let currentPage = switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupLanguage           => <SetupLanguagePage goToPage setLanguage />
        | SetupMusic              => <SetupMusicPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage />
        | SetupPlayersForGame     => <SetupPlayersPage goToPage contineToGame=true />
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

