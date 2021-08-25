
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

    let (turnState, _) = React.useContext(TurnStateContext.context)

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("Confess"))} </h1>
        <h2> {React.string(t("Everyone,"))} </h2>
        <p> {React.string(t("decide whether you want to confess"))} </p>
        {
            if turnState.hasConstable {
                <>
                    <LargeRevealButton
                        revealPrompt=t("Reveal constable's protection")
                        revelationPrompt=t("The constable protected")
                        secret=turnState.choiceConstable
                    />
                    <Spacer />
                </>
            } else {
                React.null
            }
        }
        <Button
            label={t("Next")}
            className="icon_right icon_forw"
            onClick={ _event => goToPage(_prev => DaytimeReveal) }
        />
    </div>
}


