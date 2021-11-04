
/** ****************************************************************************
 * RootPage
 */

open Types
open Types.FbDb
open Constants

let initialDbConnectionStatus = NotConnected
let initialPage: page = Title
let initialNavigation: option<page> = None

let initialGameState = {
    gameType: StandAlone,
    gameId: GameId.getGameId(),
    language: #en_US,
    players: [],
    seating: #OneAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: defaultSelectedMusicTracks,
}

let cleanupGameState = (gameState): gameState => {
    let knownMusicTracksInclude = musicTracks->Js.Array2.includes // curried
    {
        ...gameState,
        backgroundMusic: gameState.backgroundMusic->Js.Array2.filter(knownMusicTracksInclude)
    }
}

@react.component
let make = (): React.element => {

    let (dbConnectionStatus, setDbConnectionStatus)
                                    = React.useState(_ => initialDbConnectionStatus)
    let (currentPage, goToPage)     = React.useState(_ => initialPage)
    let (gameState, setGameState)   = React.useState(_ => initialGameState)
    let (navigation, setNavigation) = React.useState(_ => initialNavigation)
    let (turnState, setTurnState)   = React.useState(_ => initialTurnState)

    // run once after mounting: read localstorage.
    // if we're master, then connect to firebase.
    React.useEffect0(() => {
        LocalStorage.loadGameState()
            ->Belt.Option.map(cleanupGameState)
            ->Belt.Option.forEach(gameState => {
                setGameState(_prev => gameState)
                Utils.ifMaster(
                    gameState.gameType,
                    () => SetupMasterPage.startHosting(setDbConnectionStatus, gameState, setGameState)
                )
            })
        None // cleanup function
    })

    // save game state to localstorage after every change; and to firebase if we're hosting
    React.useEffect1(() => {
        LocalStorage.saveGameState(gameState)
        FirebaseClient.ifMasterAndConnectedThenSaveGameState(
            dbConnectionStatus, gameState, currentPage, initialTurnState, None
        )
        None // cleanup function
    }, [ gameState ])

    let currentPageElement = switch currentPage {
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

    <DbConnectionContext.Provider value=(dbConnectionStatus, setDbConnectionStatus)>
        <GameStateContext.Provider value=(gameState, setGameState)>
            <div className=LanguageCodec.languageToJs(gameState.language)>
                <NavigationContext.Provider value=(navigation, setNavigation)>
                    <TurnStateContext.Provider value=(turnState, setTurnState)>
                        {currentPageElement}
                    </TurnStateContext.Provider>
                </NavigationContext.Provider>
            </div>
        </GameStateContext.Provider>
    </DbConnectionContext.Provider>
}

