
/** ****************************************************************************
 * NightPage
 */

/*
 * var audioElement = new Audio('car_horn.wav');
 * audioElement.addEventListener('loadeddata', () => {
 *   let duration = audioElement.duration;
 *   // The duration variable now holds the duration (in seconds) of the audio clip
 * })
*/

open Types

@react.component
let make = (
    ~state: state
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    let title: string = switch NightWitch { // TODO
        | NightWitch     => t("The witches")
        | NightConstable => t("The constable")
        | _              => ""
    }
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            <div> {React.string(t(title))} </div>
            <PlayerList state={state} />
            <Audio track=TownGoToSleep />
        </div>
    </div>
}

