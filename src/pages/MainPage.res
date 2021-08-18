
/** ****************************************************************************
 * MainPage
 */

open Types
open Constants

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title

let initialGameState = {
    players: [],
    seatingLayout: #OneAtTop,
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

let loadPlayersFromLocalStorage = (setGameState): unit => {
    let storageKey = localStoragePrefix ++ localStoragePlayersKey
    LocalStorage.getStringArray(storageKey) // this yields an option<array<string>>
        ->Belt.Option.forEach(
            players => setGameState(prevState => { ...prevState, players })
        )
}

let loadTracksFromLocalStorage = (setGameState): unit => {
    let storageKey = localStoragePrefix ++ localStorageMusicKey
    LocalStorage.getStringArray(storageKey) // this yields an option<array<string>>
        ->Belt.Option.map(
            Js.Array.filter(Constants.musicTracks->Js.Array2.includes)
        )
        ->Belt.Option.forEach(
            tracks => setGameState(prevState => { ...prevState, backgroundMusic: tracks })
        )
}

let loadLanguageFromLocalStorage = (setLanguage): unit => {
    let storageKey = localStoragePrefix ++ localStorageLanguageKey
    LocalStorage.getItem(storageKey)                    // this yields an option<string>
        ->Belt.Option.flatMap(
            Translator.getLanguageByCode
        )                                               // this yields an option<language>
        ->Belt.Option.forEach(
            language => setLanguage(_prevLanguage => language)
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
        loadPlayersFromLocalStorage(setGameState)
        loadTracksFromLocalStorage(setGameState)
        loadLanguageFromLocalStorage(setLanguage)
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

