
/** ****************************************************************************
 * CreditsPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    let spacedComma = React.string(",  ")
    <div id="credits-page" className="page flex-vertical text-padding">
        <h1> {React.string(t("Credits"))} </h1>
        <Spacer />
        <dl>
            <dt> {React.string(t("Game:"))} </dt>
            <dd> {React.string(`Salem 1692 © Travis Hancock, `)}
                <a href="https://facadegames.com/"> {React.string(`Façade Games`)} </a>
            </dd>
            <dt> {React.string(t("App:"))} </dt>
            <dd> {React.string(`René Uittenbogaard © 2021`)} </dd>
            <dt> {React.string(t("Sound effects:"))} </dt>
            <dd> {React.string("Daniel Simon, ")}
                <a href="https://soundbible.com/"> {React.string("soundbible.com")} </a>
            </dd>
            <dt> {React.string(t("Voice actors:"))} </dt>
            <dd> {React.string(`René Uittenbogaard`)} </dd>
            // <dd> {React.string("Paul Scholey")} </dd>
            // <dd> {React.string("Mario Ruiz")} </dd>
            <dt> {React.string(t("Images:"))} </dt>
            <dd>
                <a href="https://www.vecteezy.com/free-vector/cog"> {React.string("Vecteezy")} </a> spacedComma
                <a href="http://www.famfamfam.com/lab/icons/silk/"> {React.string("FamFamFam")} </a> spacedComma
                <a href="https://icons8.com"> {React.string("Icons8")} </a> spacedComma
                <a href="https://clipartmag.com/download-clipart-image#paper-scrolls-clipart-38.jpg"> {React.string("ClipArtMag")} </a>
            </dd>
        </dl>
        <Spacer />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon icon_back"
        />
    </div>
}


