/* *****************************************************************************
 * RootPage
 */

open Types
open Constants

let initialDbConnectionStatus = NotConnected
let initialNavigation: option<page> = None

let setOverrideLanguage = (gameState): gameState => {
  let queryStringLanguage =
    QueryString.getQueryParam("lang")
    ->Belt.Option.map(Js.Json.string)
    ->Belt.Option.flatMap(json => json->LanguageCodec.t_decode->Utils.resultToOption)
    ->Belt.Option.getWithDefault(gameState.language)
  {
    ...gameState,
    language: queryStringLanguage,
  }
}

let setDefaultLanguage = (gameState): gameState => {
  let browserLanguage =
    BrowserLanguage.getLanguage()->Belt.Option.getWithDefault(gameState.language)
  {
    ...gameState,
    language: browserLanguage,
  }
}

let cleanupGameStateMusic = (gameState): gameState => {
  let knownMusicTracksInclude = x => musicTracks->Js.Array2.includes(x)
  {
    ...gameState,
    backgroundMusic: gameState.backgroundMusic->Js.Array2.filter(knownMusicTracksInclude),
  }
}

@react.component
let make = (): React.element => {
  let (currentPage, _goToPage) = React.useContext(RouterContext.context)

  let (dbConnectionStatus, setDbConnectionStatus) = React.useState(_ => initialDbConnectionStatus)
  let (gameState, setGameState) = React.useState(_ => initialGameState->setDefaultLanguage)
  let (navigation, setNavigation) = React.useState(_ => initialNavigation)
  let (turnState, setTurnState) = React.useState(_ => initialTurnState)

  // run once after mounting: read localstorage.
  // if we're master, then connect to firebase.
  React.useEffect0(() => {
    LocalStorage.loadGameState()
    ->Belt.Option.map(cleanupGameStateMusic)
    ->Belt.Option.map(setOverrideLanguage)
    ->Belt.Option.forEach(gameState => {
      setGameState(_prev => gameState)
      Utils.ifMaster(
        gameState.gameType,
        _gameId => SetupNetworkPage.startHosting(setDbConnectionStatus, gameState, setGameState),
      )
    })
    None // cleanup function
  })

  // save game state to localstorage after every change; and to firebase if we're hosting
  React.useEffect1(() => {
    LocalStorage.saveGameState(gameState)
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, _gameId) => {
      FirebaseClient.saveGameState(dbConnection, gameState, currentPage, initialTurnState, None)
    })
    None // cleanup function
  }, [gameState])

  let currentPageElement = switch currentPage {
  | Title => <TitlePage />
  | Setup => <SetupPage />
  | SetupLanguage => <SetupLanguagePage />
  | SetupMusic => <SetupMusicPage />
  | SetupPlayers => <SetupPlayersPage />
  | SetupNetwork => <SetupNetworkPage noGame=false />
  | SetupNetworkNoGame => <SetupNetworkPage noGame=true />
  | Credits => <CreditsPage />
  | Daytime => <DaytimePage />
  // Master
  | NightDawnOneWitch => <NightScenarioPage subPage=currentPage />
  | NightDawnMoreWitches => <NightScenarioPage subPage=currentPage />
  | NightOtherNoConstable => <NightScenarioPage subPage=currentPage />
  | NightOtherWithConstable => <NightScenarioPage subPage=currentPage />
  // Slave
  | DaytimeWaiting => <SlavePage subPage=currentPage />
  | NightWaiting => <SlavePage subPage=currentPage />
  | NightChoiceWitches => <SlavePage subPage=currentPage />
  | NightConfirmWitches => <SlavePage subPage=currentPage />
  | NightChoiceConstable => <SlavePage subPage=currentPage />
  | NightConfirmConstable => <SlavePage subPage=currentPage />
  // Master
  | DaytimeConfess => <DaytimeConfessPage />
  | DaytimeReveal => <DaytimeRevealPage />
  | DaytimeRevealNoConfess => <DaytimeRevealPage allowBackToConfess=false />
  | Close => <ClosePage />
  }

  <DbConnectionContext.Provider value=(dbConnectionStatus, setDbConnectionStatus)>
    <GameStateContext.Provider value=(gameState, setGameState)>
      <div
        lang={LanguageCodec.getHtmlLanguage(gameState.language)}
        className={gameState.language->LanguageCodec.toString}>
        <NavigationContext.Provider value=(navigation, setNavigation)>
          <TurnStateContext.Provider value=(turnState, setTurnState)>
            {currentPageElement}
          </TurnStateContext.Provider>
        </NavigationContext.Provider>
      </div>
    </GameStateContext.Provider>
  </DbConnectionContext.Provider>
}
