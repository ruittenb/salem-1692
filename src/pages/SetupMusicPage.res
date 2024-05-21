/* *****************************************************************************
 * SetupMusicPage
 */

open Types

let intro =
  "Check the boxes to compose a playlist for the nights. " ++ "Each successive night, the next track from the playlist will be played."

@react.component
let make = (): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (preview, setPreview) = React.useState(_ => None)

  let previewNode =
    preview->Option.mapOr(React.null, track =>
      <Audio
        track=Music(track ++ ".mp3") volume=1.0 onEnded={_event => setPreview(_prev => None)}
      />
    )

  let trackButtons = React.array(
    Constants.musicTracks->Js.Array2.mapi((availableTrack, index) => {
      let isIncluded = gameState.backgroundMusic->Js.Array2.includes(availableTrack)
      let toggleMusicTrack = () => {
        let newBackgroundMusic = if isIncluded {
          setPreview(_prev => None)
          gameState.backgroundMusic->Js.Array2.filter(stateTrack => stateTrack !== availableTrack)
        } else {
          setPreview(_prev => Some(availableTrack))
          gameState.backgroundMusic->Js.Array2.concat([availableTrack])
        }
        let newGameState = {
          ...gameState,
          backgroundMusic: newBackgroundMusic,
        }
        setGameState(_prevState => newGameState)
      }

      let checkedClass = if isIncluded {
        "icon-checked"
      } else {
        "icon-unchecked"
      }
      let previewClass = if preview == Some(availableTrack) {
        "playing"
      } else {
        ""
      }

      <Button
        key={Int.toString(index) ++ "/" ++ availableTrack}
        label=availableTrack
        className={"widebutton icon-left " ++ checkedClass ++ " " ++ previewClass}
        onClick={_event => toggleMusicTrack()}
      />
    }),
  )

  <div id="setup-music-page" className="page justify-start">
    <TopBar returnPage=None onBack={Some(_event => goToPage(_prev => Setup))} />
    <h1> {React.string(t("Music"))} </h1>
    {previewNode}
    <p> {React.string(t(intro))} </p>
    <Spacer />
    {trackButtons}
    <Spacer />
    <Button label={t("OK")} className="ok-button" onClick={_event => goToPage(_prev => Setup)} />
  </div>
}
