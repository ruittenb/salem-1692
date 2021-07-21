
/** ****************************************************************************
 * DaytimeConfessPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (constableSavePlayer, _): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.contextConstable)

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("Confess"))} </h1>
        <Spacer />
        <h2> {React.string(t("Everyone,"))} </h2>
        <p> {React.string(t("decide whether you want to confess"))} </p>
        <Spacer />
        <LargeButton onClick={ _event => goToPage(_prev => Daytime) } > /* todo state: revealed */
            {React.string(t("Reveal constable's protection"))} /* only if a player was chosen */
        </LargeButton>
        <Spacer />
        <Button
            label={t("Next")}
            className="icon_right icon_forw"
            onClick={ _event => goToPage(_prev => DaytimeReveal) }
        />
    </div>
}


