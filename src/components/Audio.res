
/** ****************************************************************************
 * Audio
 *
 * See also: https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement
 */

open Types

let getLanguageDirectory = (language: language): string => {
    switch language {
        | NL_NL => "nl_NL/"
        | EN_US => "en_US/"
        | ES_ES => "es_ES/"
    }
}

@react.component
let make = (
    ~track: scenarioStep,
    ~proceed: mediaHandler,
): React.element => {

    let language = React.useContext(LanguageContext.context)
    let effectDirectory = "audio/"
    let speechDirectory = "audio/" ++ getLanguageDirectory(language)

    let src = switch track {
        | Effect(Silence)             => effectDirectory ++ "silence.mp3"
        | Effect(Rooster)             => effectDirectory ++ "rooster.mp3"
        | Effect(ChurchBell)          => effectDirectory ++ "tolling-bell-once.mp3"

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
        | _                           => effectDirectory ++ "silence.mp3"
    }
    <audio src
        autoPlay=true
        onEnded={ proceed }
    />
}

