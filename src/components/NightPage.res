
/** ****************************************************************************
 * NightPage
 */

open Types

@react.component
let make = (
    ~state: state
): React.element => {
    let locale = React.useContext(Context.Locale.context)
    let t = Translator.getTranslator(locale)
    let title: string = switch state.currentPage {
        | NightWitch     => t("The witches")
        | NightConstable => t("The constable")
        | _              => ""
    }
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            <div> {React.string(t(title))} </div>
            <PlayerList state={state} />
        </div>
    </div>
}

