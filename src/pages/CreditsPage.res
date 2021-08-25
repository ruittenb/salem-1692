
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
    let spacedComma = React.string(", ")
    <div id="credits-page" className="page flex-vertical text-padding">
        <h1> {React.string(t("Credits"))} </h1>
        <Spacer />
        <p>
            <span> {React.string(t("App: "))} </span>
            <a href="https://ruittenb.github.io/salem-1692/dist/"> {React.string(t("website"))} </a> spacedComma
            {React.string(t("version") ++ " v" ++ salemAppVersion ++ ` René Uittenbogaard © 2021`)}
        </p>
        <p>
            <span> {React.string(t("For use with the game: "))} </span>
            <a href="https://facadegames.com/products/salem-1692">
            {React.string("Salem 1692")}
            </a>
            {React.string(`, Travis Hancock © 2015, `)}
            <a href="https://facadegames.com/"> {React.string(`Façade Games`)} </a>
        </p>
        <p>
            <span> {React.string(t("Voice actors: "))} </span>
            {React.string("Helmi Megens")} /* {React.string("Paul Scholey")} {React.string("Mario Ruiz")} */
        </p>
        <p>
            <span> {React.string(t("Music: "))} </span>
            {
                React.array(
                    Constants.musicTracks->Js.Array2.mapi((track, index) => {
                        <React.Fragment key={ Belt.Int.toString(index) ++ "/" ++ track } >
                            <a href={"https://incompetech.com/music/royalty-free/mp3-royaltyfree/" ++ track ++ ".mp3"} >
                                {React.string(track)}
                            </a>
                            spacedComma
                        </React.Fragment>
                    })
                )
            }
            {React.string(`© `)}
            <a href="https://incompetech.com/music/royalty-free/music.html"> {React.string("Kevin MacLeod")} </a> spacedComma
            {React.string(t("Licensed under") ++ " ")}
            <a href="http://creativecommons.org/licenses/by/4.0/"> {React.string("CC BY 4.0")} </a>
        </p>
        <p>
            <span> {React.string(t("Sound effects: "))} </span>
            <a href="https://soundbible.com/2206-Tolling-Bell.html"> {React.string("Daniel Simion")} </a> spacedComma
            <a href="https://soundbible.com/1218-Rooster-Crow.html"> {React.string("Mike Koenig")} </a> spacedComma
            <a href="https://mixkit.co/free-sound-effects/buzzer/"> {React.string("mixkit.co")} </a>
        </p>
        <p>
            <span> {React.string(t("Images: "))} </span>
            <a href="https://www.dreamstime.com/cute-funny-old-gramophone-image185881168"> {React.string("Ogieurvil")} </a> spacedComma
            <a href="https://clipartmag.com/download-clipart-image#paper-scrolls-clipart-38.jpg"> {React.string("ClipArtMag")} </a> spacedComma
            <a href="https://flagpedia.net"> {React.string("Flagpedia")} </a> spacedComma
            <a href="https://www.flaticon.com/free-icon/chess-piece_891932"> {React.string("FlatIcon")} </a> spacedComma
            <a href="https://cliparts.zone/clipart/541458"> {React.string("ClipArtsZone")} </a> spacedComma
            <a href="http://www.famfamfam.com/lab/icons/silk/"> {React.string("FamFamFam")} </a> spacedComma
            <a href="https://www.freepik.com/free-vector/"> {React.string("Freepik")} </a> spacedComma
            <a href="https://icons8.com"> {React.string("Icons8")} </a> spacedComma
            <a href="https://www.freepik.com/free-vector/old-town_11575329.htm"> {React.string("brgfx")} </a> spacedComma
            <a href="https://openclipart.org/detail/10065/lute-1"> {React.string("papapishu")} </a>
        </p>
        <Spacer />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon-left icon-back"
        />
    </div>
}


