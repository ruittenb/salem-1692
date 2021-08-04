
/** ****************************************************************************
 * CreditsPage
 */

open Types

@val external salemAppVersion: string = "salemAppVersion"

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)
    let spacedComma = React.string(",  ")
    let closeParen = React.string(")")
    <div id="credits-page" className="page flex-vertical text-padding">
        <h1> {React.string(t("Credits"))} </h1>
        <Spacer />
        <p>
            <span> {React.string(t("App:"))} </span>
            {React.string(" " ++ t("version") ++ " v" ++ salemAppVersion ++ ` René Uittenbogaard © 2021`)}
        </p>
        <p>
            <span> {React.string(t("For use with the game:"))} </span>
            {React.string(` Salem 1692, Travis Hancock © 2015, `)}
            <a href="https://facadegames.com/"> {React.string(`Façade Games`)} </a>
        </p>
        <p>
            <span> {React.string(t("Sound effects:"))} </span>
            {React.string(" Daniel Simon (")}
            <a href="https://soundbible.com/"> {React.string("soundbible.com")} </a> closeParen spacedComma
            <a href="https://mixkit.co/free-sound-effects/buzzer/"> {React.string("mixkit.co")} </a>
        </p>
        <p>
            <span> {React.string(t("Voice actors:"))} </span>
            {React.string(" Helmi Megens")} /* {React.string("Paul Scholey")} {React.string("Mario Ruiz")} */
        </p>
        <p>
            <span> {React.string(t("Images:"))} </span>
            {React.string(" ")}
            <a href="https://www.freepik.com/free-vector/cross-icons-collection_806517.htm#page=1&query=cross&position=16"> {React.string("Freepik")} </a> spacedComma
            <a href="https://www.vecteezy.com/free-vector/cog"> {React.string("Vecteezy")} </a> spacedComma
            <a href="http://www.famfamfam.com/lab/icons/silk/"> {React.string("FamFamFam")} </a> spacedComma
            <a href="https://icons8.com"> {React.string("Icons8")} </a> spacedComma
            <a href="https://flagpedia.net"> {React.string("Flagpedia")} </a> spacedComma
            <a href="https://clipartmag.com/download-clipart-image#paper-scrolls-clipart-38.jpg"> {React.string("ClipArtMag")} </a> spacedComma
            <a href="https://www.flaticon.com/free-icon/chess-piece_891932"> {React.string("FlatIcon")} </a>
        </p>
        <Spacer />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon-left icon-back"
        />
    </div>
}


