
/** ****************************************************************************
 * DaytimeConfessPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)
    let (turnState, _) = React.useContext(TurnStateContext.context)

    <div id="daytime-confess-page" className="page flex-vertical">
        <h1> {React.string(t("Confess"))} </h1>
        <h2> {React.string(t("Everyone,"))} </h2>
        <p> {React.string(t("decide whether you want to confess"))} </p>
        {
            if turnState.hasConstable {
                <>
                    <LargeRevealButton
                        revealPrompt=t("Reveal constable's protection")
                        revelationPromptPre=t("The constable protected-PRE")
                        revelationPromptPost=t("The constable protected-POST")
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
            className="icon-right icon-forw"
            onClick={ _event => goToPage(_prev => DaytimeReveal) }
        />
    </div>
}


