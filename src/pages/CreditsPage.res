/** ****************************************************************************
 * CreditsPage
 */

open Types

@val external salemAppVersion: string = "salemAppVersion"

let nnbsp = ` ` // U+202F Narrow No-Break Space
let nbsp  = ` ` // U+00A0 No-Break Space
let note  = `♪` // U+266A Eighth Note (quaver)
let year = "2022"

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let spacedComma = React.string(", ")

    let trackList = React.array(
        Constants.musicTracks->Js.Array2.mapi((track, index) => {
            <React.Fragment key={ Belt.Int.toString(index) ++ "/" ++ track } >
            <a href={"https://incompetech.com/music/royalty-free/mp3-royaltyfree/" ++ track ++ ".mp3"} >
            {React.string(track ++ nnbsp ++ note)}
            </a>
            spacedComma
            </React.Fragment>
        })
    )

    <div id="credits-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => Setup) } />
        <h1> {React.string(t("Credits"))} </h1>
        <Spacer />
        <p className="noblur">
            <span> {React.string(t("App: "))} </span>
            <a href={Constants.siteUrl}> {React.string(t("website"))} </a>
            <QrIcon mode={QrIcon.Scannable(Constants.siteUrl)} />
            {React.string(t("version") ++ " v" ++ salemAppVersion ++ ` René Uittenbogaard © ` ++ year)}
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
            {React.string("Helmi Megens, Mario Ruiz, Paul Scholey, ")}
            <a href="https://www.fiverr.com/mrvoice">
                {React.string("Christopher Badziong")}
            </a> spacedComma
            <a href="https://www.fiverr.com/ruffer">
                {React.string("Quentin ")}
                <i> {React.string("(Ruffer)")} </i>
            </a> spacedComma
            {React.string(t("Licensed under") ++ " ")}
            <a href="http://creativecommons.org/licenses/by-sa/4.0/"> {React.string("CC BY-SA 4.0")} </a>
        </p>
        <p>
            <span> {React.string(t("Music: "))} </span>
            {trackList}
            {React.string(`© `)}
            <a href="https://incompetech.com/music/royalty-free/music.html"> {React.string("Kevin MacLeod")} </a> spacedComma
            {React.string(t("Licensed under") ++ " ")}
            <a href="http://creativecommons.org/licenses/by/4.0/"> {React.string("CC BY 4.0")} </a>
        </p>
        <p>
            <span> {React.string(t("Sound effects: "))} </span>
            <a href="https://soundbible.com/2206-Tolling-Bell.html"> {React.string("Daniel Simion")} </a> spacedComma
            <a href="https://soundbible.com/1218-Rooster-Crow.html"> {React.string("Mike Koenig")} </a> spacedComma
            <a href="https://soundbible.com/2083-Crickets-Chirping-At-Night.html"> {React.string("Lisa Redfern")} </a> spacedComma
            <a href="https://soundbible.com/1954-Cat-Meow-2.html"> {React.string("Cat Stevens")} </a> spacedComma
            <a href="https://mixkit.co/free-sound-effects/buzzer/"> {React.string("mixkit.co")} </a>
        </p>
        <p>
            <span> {React.string(t("Images: "))} </span>
            <a href="https://www.dreamstime.com/cute-funny-old-gramophone-image185881168"> {React.string("Ogieurvil")} </a> spacedComma
            <a href="https://openclipart.org/detail/10065/lute-1"> {React.string("papapishu")} </a> spacedComma
            <a href="https://clipartmag.com/download-clipart-image#paper-scrolls-clipart-38.jpg"> {React.string("ClipArtMag")} </a> spacedComma
            <a href="https://cliparts.zone/clipart/541458"> {React.string("ClipArtsZone")} </a> spacedComma
            {React.string("FlatIcon: ")}
            <a href="https://www.flaticon.com/free-icon/chess-piece_891932"> {React.string("Pixel perfect")} </a> spacedComma
            <a href="https://www.flaticon.com/authors/gregor-cresnar"> {React.string("Gregor Cresnar")} </a> spacedComma
            {React.string("Freepik: ")}
            <a href="https://www.freepik.com/free-vector/magic-set_3886841.htm"> {React.string("macrovector")} </a> spacedComma
            <a href="https://www.freepik.com/free-vector/old-town_11575329.htm"> {React.string("brgfx")} </a> spacedComma
            <a href="https://www.freepik.com/free-vector/realistic-wooden-barrel-wine-beer_7773530.htm"> {React.string("upklyak")} </a> spacedComma
            <a href="https://flagpedia.net"> {React.string("Flagpedia")} </a> spacedComma
            <a href="https://icons8.com"> {React.string("Icons8")} </a> spacedComma
            <a href="http://www.famfamfam.com/lab/icons/silk/"> {React.string("FamFamFam")} </a>
        </p>
        <Spacer />
        <Button
            label={t("OK")}
            className="ok-button"
            onClick={ _event => goToPage(_prev => Setup) }
        />
        <Spacer />
    </div>
}

