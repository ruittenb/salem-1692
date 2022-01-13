/** ****************************************************************************
 * RootPage
 */

open Types
open Constants

let initialDbConnectionStatus = NotConnected
let initialPage: page = Title
let initialNavigation: option<page> = None

let initialGameState = {
    gameType: StandAlone,
    gameId: GameId.getGameId(),
    language: #en_US,
    players: [ "Anastasia", "Agatha", "Ambrosia" ],
    seating: #OneAtTop,
    doPlayEffects: true,
    doPlaySpeech: true,
    doPlayMusic: true,
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
                    () => SetupNetworkPage.startHosting(setDbConnectionStatus, gameState, setGameState)
                )
            })
        None // cleanup function
    })

    // save game state to localstorage after every change; and to firebase if we're hosting
    React.useEffect1(() => {
        LocalStorage.saveGameState(gameState)
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection) => {
            FirebaseClient.saveGameState(dbConnection, gameState, currentPage, initialTurnState, None)
        })
        None // cleanup function
    }, [ gameState ])

    let currentPageElement = switch currentPage {
        | Title                   => <TitlePage goToPage />
        | Setup                   => <SetupPage goToPage />
        | SetupLanguage           => <SetupLanguagePage goToPage />
        | SetupMusic              => <SetupMusicPage goToPage />
        | SetupPlayers            => <SetupPlayersPage goToPage />
        | SetupNetwork            => <SetupNetworkPage goToPage noGame=false />
        | SetupNetworkNoGame      => <SetupNetworkPage goToPage noGame=true />
        | Credits                 => <CreditsPage goToPage />
        | Daytime                 => <DaytimePage goToPage />
        // Master
        | NightFirstOneWitch      => <NightScenarioPage goToPage subPage=currentPage />
        | NightFirstMoreWitches   => <NightScenarioPage goToPage subPage=currentPage />
        | NightOtherNoConstable   => <NightScenarioPage goToPage subPage=currentPage />
        | NightOtherWithConstable => <NightScenarioPage goToPage subPage=currentPage />
        // Slave
        | DaytimeWaiting          => <SlavePage goToPage subPage=currentPage />
        | NightWaiting            => <SlavePage goToPage subPage=currentPage />
        | NightChoiceWitches      => <SlavePage goToPage subPage=currentPage />
        | NightConfirmWitches     => <SlavePage goToPage subPage=currentPage />
        | NightChoiceConstable    => <SlavePage goToPage subPage=currentPage />
        | NightConfirmConstable   => <SlavePage goToPage subPage=currentPage />
        // Master
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

