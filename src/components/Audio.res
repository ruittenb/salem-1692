/* *****************************************************************************
 * Audio
 *
 * See also:
 * - https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement
 * - https://github.com/reasonml-community/bs-webapi-incubator
 * - https://dev.to/jdeisenberg/manipulating-the-dom-with-rescript-3llf
 */

open Types

@set external setVolume: (Dom.htmlAudioElement, float) => unit = "volume"
external unsafeAsHtmlAudioElement: Dom.element => Dom.htmlAudioElement = "%identity"

let p = "[Audio] "

// Fade out over 1s
let fadeInterval = 100 // milliseconds
let fadeStep = 0.1

@react.component
let make = (
  ~track: audioType,
  ~volume: float=1.0,
  ~loop: bool=false,
  ~onEnded: mediaHandler=_ => (),
  ~onError: mediaHandler=_ => (),
): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)

  let audioRef = React.useRef(Nullable.null)

  // run after mounting
  React.useEffect0(() => {
    audioRef.current
    ->Nullable.toOption
    ->Option.forEach(domNode =>
      domNode
      ->Utils.ifTagName("AUDIO")
      ->Option.forEach(domNode => domNode->unsafeAsHtmlAudioElement->setVolume(volume))
    )
    None // cleanup function
  })

  let musicDirectory = "audio/music/"
  let effectDirectory = "audio/effects/"
  let speechDirectory = "audio/" ++ (gameState.language :> string) ++ "/"

  let src = switch track {
  | Speech(TownGoToSleep) => speechDirectory ++ "town-go-to-sleep.mp3"
  | Speech(TownStillAsleep) => speechDirectory ++ "town-still-asleep.mp3"
  | Speech(WitchWakeUp) => speechDirectory ++ "witch-wake-up.mp3"
  | Speech(WitchesWakeUp) => speechDirectory ++ "witches-wake-up.mp3"
  | Speech(WitchDecideCat) => speechDirectory ++ "witch-decide-cat.mp3"
  | Speech(WitchesDecideCat) => speechDirectory ++ "witches-decide-cat.mp3"
  | Speech(WitchesDecideMurder) => speechDirectory ++ "witches-decide-murder.mp3"
  | Speech(WitchGoToSleep) => speechDirectory ++ "witch-go-to-sleep.mp3"
  | Speech(WitchesGoToSleep) => speechDirectory ++ "witches-go-to-sleep.mp3"
  | Speech(ConstableWakeUp) => speechDirectory ++ "constable-wake-up.mp3"
  | Speech(ConstableDecideAny) => speechDirectory ++ "constable-decide-any.mp3"
  | Speech(ConstableDecideOther) => speechDirectory ++ "constable-decide-other.mp3"
  | Speech(ConstableGoToSleep) => speechDirectory ++ "constable-go-to-sleep.mp3"
  | Speech(TownWakeUp) => speechDirectory ++ "town-wake-up.mp3"

  | Effect(CatMeowing) => effectDirectory ++ "cat-meowing.mp3"
  | Effect(ChurchBell) => effectDirectory ++ "church-bell.mp3"
  | Effect(Crickets) => effectDirectory ++ "crickets.mp3"
  | Effect(DogBarking) => effectDirectory ++ "dog-barking.mp3"
  | Effect(Footsteps) => effectDirectory ++ "footsteps.mp3"
  | Effect(Lark) => effectDirectory ++ "lark.mp3"
  | Effect(Rooster) => effectDirectory ++ "rooster.mp3"
  | Effect(Silence1s) => effectDirectory ++ "silence-1s.mp3"
  | Effect(Silence2s) => effectDirectory ++ "silence-2s.mp3"
  | Effect(Thunderstrike) => effectDirectory ++ "thunderstrike.mp3"

  | Music(fileName) => musicDirectory ++ fileName
  }

  <audio src loop autoPlay=true onEnded onError ref={ReactDOM.Ref.domRef(audioRef)} />
}
