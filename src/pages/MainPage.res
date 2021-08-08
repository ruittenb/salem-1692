
/** ****************************************************************************
 * MainPage
 */

open Types
open Utils
open Constants

let initialLanguage: Types.language = EN_US
let initialPage: Types.page = Title

let initialGameState = {
    players: [],
    seatingLayout: OneAtHead,
    doPlayEffects: true,
    doPlaySpeech: true,
    backgroundMusic: Some("Egmont Overture.mp3"),
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
    LocalStorage.getItem(storageKey)                    // this yields an option<string>
        ->option2AndThen(
            playersString => safeExec(
                () => Js.Json.parseExn(playersString),
            )
        )                                               // this yields an option<Js.Json.t>
        ->option2AndThen(
            json => Js.Json.decodeArray(json),
        )                                               // this yields an option<array<Js.Json.t>>
        ->option2Map(
            jsonString => jsonString
                ->Js.Array2.map(Js.Json.decodeString)   // this yields an array<option<string>>
                ->arrayFilterSome                       // this yields an array<string>
        )                                               // this yields an option<array<string>>
        ->option2AndExec(
            players => setGameState(prevState => { ...prevState, players })
        )
}

let loadLanguageFromLocalStorage = (setLanguage): unit => {
    let storageKey = localStoragePrefix ++ localStorageLanguageKey
    LocalStorage.getItem(storageKey)                    // this yields an option<string>
        ->option2AndThen(
            Translator.getLanguageByCode
        )                                               // this yields an option<language>
        ->option2AndExec(
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
        loadLanguageFromLocalStorage(setLanguage)
        None // cleanup function
    })

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

