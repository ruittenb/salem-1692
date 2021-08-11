
/** ****************************************************************************
 * Audio
 *
 * See also:
 * - https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement
 * - https://github.com/reasonml-community/bs-webapi-incubator
 * - https://dev.to/jdeisenberg/manipulating-the-dom-with-rescript-3llf
 */

open Types

@set external setVolume: (Dom.htmlAudioElement, float) => unit = "volume"
external unsafeAsHtmlAudioElement : Dom.element => Dom.htmlAudioElement = "%identity"

let getLanguageDirectory = (language: language): string => {
    switch language {
        | NL_NL => "nl_NL/"
        | EN_US => "en_US/"
        | ES_ES => "es_ES/"
    }
}

@react.component
let make = (
    ~track: audioType,
    ~volume: float = 1.0,
    ~loop: bool = false,
    ~onEnded: mediaHandler = _ => (),
    ~onError: mediaHandler = _ => (),
): React.element => {

    let (language, _translator) = React.useContext(LanguageContext.context)

    let audioRef = React.useRef(Js.Nullable.null)

    // run after mounting
    React.useEffect0(() => {
        audioRef.current
            ->Js.Nullable.toOption
            ->Belt.Option.forEach(
                domNode => domNode
                    ->unsafeAsHtmlAudioElement
                    ->setVolume(volume)
            )
        None // cleanup function
    })

    let musicDirectory  = "audio/music/"
    let effectDirectory = "audio/effects/"
    let speechDirectory = "audio/" ++ getLanguageDirectory(language)

    let src = switch track {
        | Speech(TownGoToSleep)       => speechDirectory ++ "town-go-to-sleep.mp3"
        | Speech(WitchWakeUp)         => speechDirectory ++ "witch-wake-up.mp3"
        | Speech(WitchesWakeUp)       => speechDirectory ++ "witches-wake-up.mp3"
        | Speech(WitchDecideCat)      => speechDirectory ++ "witch-decide-cat.mp3"
        | Speech(WitchesDecideCat)    => speechDirectory ++ "witches-decide-cat.mp3"
        | Speech(WitchesDecideMurder) => speechDirectory ++ "witches-decide-murder.mp3"
        | Speech(WitchGoToSleep)      => speechDirectory ++ "witch-go-to-sleep.mp3"
        | Speech(WitchesGoToSleep)    => speechDirectory ++ "witches-go-to-sleep.mp3"
        | Speech(ConstableWakeUp)     => speechDirectory ++ "constable-wake-up.mp3"
        | Speech(ConstableGoToSleep)  => speechDirectory ++ "constable-go-to-sleep.mp3"
        | Speech(TownWakeUp)          => speechDirectory ++ "town-wake-up.mp3"

        | Effect(Silence1s)           => effectDirectory ++ "silence-1s.mp3"
        | Effect(Silence2s)           => effectDirectory ++ "silence-2s.mp3"
        | Effect(Rooster)             => effectDirectory ++ "rooster.mp3"
        | Effect(ChurchBell)          => effectDirectory ++ "church-bell-once.mp3"

        | Music(fileName)             => musicDirectory ++ fileName
    }
    <audio src loop autoPlay=true
        onEnded
        onError
        ref={ReactDOM.Ref.domRef(audioRef)}
    />
}

