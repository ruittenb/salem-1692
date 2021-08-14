
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
    let (preview,   setPreview)   = React.useState(_ => None)

    let previewNode = preview
        ->Belt.Option.mapWithDefault(
            React.null,
            track => <Audio
                track=Music(track ++ ".mp3")
                volume=1.0
                onEnded=(_event => setPreview(_prev => None))
            />
        )

    let trackButtons = React.array(
        Constants.musicTracks->Js.Array2.mapi((availableTrack, index) => {

            let isIncluded = gameState.backgroundMusic->Js.Array2.includes(availableTrack)
            let toggleMusicTrack = () => {
                let newBackgroundMusic = if isIncluded {
                    setPreview(_prev => None)
                    gameState.backgroundMusic->Js.Array2.filter(
                        stateTrack => stateTrack !== availableTrack
                    )
                } else {
                    setPreview(_prev => Some(availableTrack))
                    gameState.backgroundMusic->Js.Array2.concat([ availableTrack ])
                }
                setGameState(prevState => {
                    ...prevState,
                    backgroundMusic: newBackgroundMusic
                })
            }

            let checkedClass = if isIncluded { "icon-checked" } else { "icon-unchecked" }
            let previewClass = if preview == Some(availableTrack) { "playing" } else { "" }

            <Button
                key={ Belt.Int.toString(index) ++ "/" ++ availableTrack }
                label=availableTrack
                className={"widebutton icon-left " ++ checkedClass ++ " " ++ previewClass}
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
        {previewNode}
        <div className="paragraph">
            {React.string(t("Check the boxes to compose a playlist for the nights. Each successive night, the next track from the playlist will be played."))}
        </div>
        <Spacer />
        {trackButtons}
        <Spacer />
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => leavePage() }
        />
    </div>
}


