/** ****************************************************************************
 * CreditsPage
 */

open Types
open Constants

@val external salemAppVersion: string = "salemAppVersion"

let nnbsp = ` ` // U+202F Narrow No-Break Space
let _nbsp = ` ` // U+00A0 No-Break Space
let note  = `♪` // U+266A Eighth Note (quaver)
let year = "2022"
let spacedComma = React.string(", ")
let openParen = React.string(" (")
let closeParenAndComma = React.string("), ")

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let rulebookUrl = "doc/" ++ switch (gameState.language) {
        | #es_ES => `Salem 1692 - Reglas Español (2nd Edition).pdf`
        | #fr_FR => `Salem 1692 - Règles Français.pdf`
        | #de_DE => "Salem 1692 - Spielregeln Deutsch.pdf"
        | #nl_NL
        | #en_US => "Salem 1692 - Rulebook English (6th Edition).pdf"
    }

    let trackList = React.array(
        Constants.musicTracks->Js.Array2.mapi((track, index) => {
            <React.Fragment key={ Belt.Int.toString(index) ++ "/" ++ track } >
            <Link
                href={"https://incompetech.com/music/royalty-free/mp3-royaltyfree/" ++ track ++ ".mp3"}
                text={track ++ nnbsp ++ note}
            />
            spacedComma
            </React.Fragment>
        })
    )

    <div id="credits-page" className="page justify-start">
        <BackFloatingButton onClick={ _event => goToPage(_prev => Setup) } />
        <h1> {React.string(t("Credits"))} </h1>
        <Spacer />
        <p className="noblur">
            <span> {React.string(t("App: "))} </span>
            <Link href=siteUrl text={t("website")} />
            <QrIcon mode={QrIcon.Scannable(siteUrl)} />
            {React.string(t("version") ++ " v" ++ salemAppVersion ++ ` René Uittenbogaard © ` ++ year)}
        </p>
        <p>
            <span> {React.string(t("For use with the game: "))} </span>
            <Link href="https://facadegames.com/products/salem-1692" text="Salem 1692" />
            openParen <Link href=rulebookUrl text={t("Rulebook")} /> closeParenAndComma
            {React.string(`Travis Hancock ©` ++ nnbsp ++ " 2015")} spacedComma
            <Link href="https://facadegames.com/" text=`Façade Games` />
        </p>
        <p>
            <span> {React.string(t("Voice actors: "))} </span>
            {React.string("Helmi Megens, Mario Ruiz, Paul Scholey, ")}
            <Link href="https://www.fiverr.com/mrvoice" text="Christopher Badziong" /> spacedComma
            <Link href="https://www.fiverr.com/ruffer">
                {React.string("Quentin ")} <i> {React.string("(Ruffer)")} </i>
            </Link> spacedComma
            {React.string(t("Licensed under") ++ " ")}
            <Link href="http://creativecommons.org/licenses/by-sa/4.0/" text="CC BY-SA 4.0" />
        </p>
        <p>
            <span> {React.string(t("Music: "))} </span>
            {trackList}
            {React.string(`© `)}
            <Link href="https://incompetech.com/music/royalty-free/music.html" text="Kevin MacLeod" /> spacedComma
            {React.string(t("Licensed under") ++ " ")}
            <Link href="http://creativecommons.org/licenses/by/4.0/" text="CC BY 4.0" />
        </p>
        <p>
            <span> {React.string(t("Sound effects: "))} </span>
            <Link href="https://soundbible.com/2206-Tolling-Bell.html" text="Daniel Simion" /> spacedComma
            <Link href="https://soundbible.com/1218-Rooster-Crow.html" text="Mike Koenig" /> spacedComma
            <Link href="https://soundbible.com/2083-Crickets-Chirping-At-Night.html" text="Lisa Redfern" /> spacedComma
            <Link href="https://soundbible.com/1954-Cat-Meow-2.html" text="Cat Stevens" /> spacedComma
            <Link href="https://mixkit.co/free-sound-effects/buzzer/" text="mixkit.co" />
        </p>
        <p>
            <span> {React.string(t("Images: "))} </span>
            <Link href="https://www.dreamstime.com/cute-funny-old-gramophone-image185881168" text="Ogieurvil" /> spacedComma
            <Link href="https://openclipart.org/detail/10065/lute-1" text="papapishu" /> spacedComma
            <Link href="https://www.flaticon.com/free-icon/chess-piece_891932" text="Pixel perfect" /> spacedComma
            <Link href="https://www.flaticon.com/authors/gregor-cresnar" text="Gregor Cresnar" /> spacedComma
            <Link href="https://www.freepik.com/free-vector/magic-set_3886841.htm" text="macrovector" /> spacedComma
            <Link href="https://www.freepik.com/free-vector/mountains-silhouette-sunrise_5378569.htm" text="pikisuperstar" /> spacedComma
            <Link href="https://www.freepik.com/free-vector/old-town_11575329.htm" text="brgfx" /> spacedComma
            <Link href="https://www.freepik.com/free-vector/realistic-wooden-barrel-wine-beer_7773530.htm" text="upklyak" /> spacedComma
            <Link href="https://cliparts.zone/clipart/541458" text="ClipArtsZone" /> spacedComma
            <Link href="https://pixabay.com/" text="Pixabay" /> spacedComma
            <Link href="https://clipartmag.com/download-clipart-image#paper-scrolls-clipart-38.jpg" text="ClipArtMag" /> spacedComma
            <Link href="https://flagpedia.net" text="Flagpedia" /> spacedComma
            <Link href="https://icons8.com" text="Icons8" /> spacedComma
            <Link href="http://www.famfamfam.com/lab/icons/silk/" text="FamFamFam" />
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

