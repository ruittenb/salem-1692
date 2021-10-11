
/** ****************************************************************************
 * RootPage
 */

open Types
open Constants

let initialPage: page = Title
let initialNavigation: option<page> = None

let initialGameState = {
    gameType: StandAlone,
    language: #en_US,
    players: [],
    seating: #OneAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: defaultSelectedMusicTracks,
}
let initialTurnState = {
    nrWitches: One,
    choiceWitches: None,
    choiceConstable: None,
}

let validateGameState = (gameState): gameState => {
    let knownMusicTracksInclude = musicTracks->Js.Array2.includes // curried
    {
        ...gameState,
        backgroundMusic: gameState.backgroundMusic->Js.Array2.filter(knownMusicTracksInclude)
    }
}

let loadGameStateFromLocalStorage = (setGameState): unit => {
    LocalStorage.loadGameState()
        ->Belt.Option.map(validateGameState)
        ->Belt.Option.forEach(
            gameState => setGameState(_prev => gameState)
        )
}

@react.component
let make = (): React.element => {

    let (currentPage, goToPage)     = React.useState(_ => initialPage)
    let (gameState, setGameState)   = React.useState(_ => initialGameState)
    let (navigation, setNavigation) = React.useState(_ => initialNavigation)
    let (turnState, setTurnState)   = React.useState(_ => initialTurnState)

    // run once after mounting
    React.useEffect0(() => {
        loadGameStateFromLocalStorage(setGameState)
        None // cleanup function
    })

    let currentPage = switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupLanguage           => <SetupLanguagePage goToPage />
        | SetupMusic              => <SetupMusicPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage returnPage=Setup />
        | SetupPlayersForGame     => <SetupPlayersPage goToPage returnPage=Title />
        | SetupMaster             => <SetupMasterPage goToPage />
        | SetupSlave              => <SetupSlavePage goToPage />
        | Credits                 => <CreditsPage goToPage />
        | Daytime                 => <DaytimePage goToPage />
        | FirstNightOneWitch      => <NightScenarioPage goToPage subPage=currentPage />
        | FirstNightMoreWitches   => <NightScenarioPage goToPage subPage=currentPage />
        | OtherNightNoConstable   => <NightScenarioPage goToPage subPage=currentPage />
        | OtherNightWithConstable => <NightScenarioPage goToPage subPage=currentPage />
        | DaytimeConfess          => <DaytimeConfessPage goToPage />
        | DaytimeReveal           => <DaytimeRevealPage goToPage />
        | DaytimeRevealNoConfess  => <DaytimeRevealPage goToPage allowBackToConfess=false />
        | Close                   => <ClosePage />
    }

    <GameStateContext.Provider value=(gameState, setGameState)>
        <div className=LanguageCodec.languageToJs(gameState.language)>
            <NavigationContext.Provider value=(navigation, setNavigation)>
                <TurnStateContext.Provider value=(turnState, setTurnState)>
                    {currentPage}
                </TurnStateContext.Provider>
            </NavigationContext.Provider>
        </div>
    </GameStateContext.Provider>
}

