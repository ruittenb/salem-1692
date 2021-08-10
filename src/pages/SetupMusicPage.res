
/** ****************************************************************************
 * SetupMusicPage
 */

open Types
open Constants

let saveTracksToLocalStorage = (tracks: array<string>): unit => {
    let storageKey = localStoragePrefix ++ localStorageMusicKey
    switch Js.Json.stringifyAny(tracks) {
        | Some(jsonString) => LocalStorage.setItem(storageKey, jsonString)
        | None             => ()
    }
}

@react.component
let make = (
    ~goToPage,
): React.element => {

    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let trackButtons = React.array(
        Constants.musicTracks->Js.Array2.mapi((availableTrack, index) => {

            let isIncluded = gameState.backgroundMusic->Js.Array2.includes(availableTrack)
            let toggleMusicTrack = () => {
                let newBackgroundMusic = if isIncluded {
                    gameState.backgroundMusic->Js.Array2.filter(
                        stateTrack => stateTrack !== availableTrack
                    )
                } else {
                    gameState.backgroundMusic->Js.Array2.concat([ availableTrack ])
                }
                setGameState(prevState => {
                    ...prevState,
                    backgroundMusic: newBackgroundMusic
                })
            }

            <Button
                key={ Belt.Int.toString(index) ++ "/" ++ availableTrack }
                label=availableTrack
                className={"widebutton icon-left " ++ if isIncluded { "icon-checked" } else { "icon-unchecked" }}
                onClick={ _event => toggleMusicTrack() }
            />
        })
    )

    let leavePage = () => {
        saveTracksToLocalStorage(gameState.backgroundMusic)
        goToPage(_prev => Setup)
    }

    <div id="setup-music-page" className="page flex-vertical">
        <h1> {React.string(t("Music"))} </h1>
        <Spacer />
        {trackButtons}
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => leavePage() }
        />
    </div>
}


