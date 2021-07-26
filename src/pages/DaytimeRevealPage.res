
/** ****************************************************************************
 * DaytimeRevealPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (turnState, _) = React.useContext(TurnStateContext.context)

    let (
        witchesRevealPrompt,
        witchesRevelationPromptPre,
        witchesRevelationPromptPost
    ) = if turnState.nrWitches === 1 {
        (
            t("Reveal witch's victim"),
            t("The witch attacked-PRE"),
            t("The witch attacked-POST"),
        )
    } else {
        (
            t("Reveal witches' victim"),
            t("The witches attacked-PRE"),
            t("The witches attacked-POST"),
        )
    }

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("The Reveal"))} </h1>
        <Spacer />
        <LargeRevealButton
            revealPrompt=witchesRevealPrompt
            revelationPromptPre=witchesRevelationPromptPre
            revelationPromptPost=witchesRevelationPromptPost
            secret=turnState.choiceWitches
        />
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
        <ButtonPair>
            <Button
                label={t("Back")}
                className="icon-left icon-back"
                onClick={ _event => goToPage(_prev => DaytimeConfess) }
            />
            <Button
                label={t("Next")}
                className="icon-right icon-forw"
                onClick={ _event => goToPage(_prev => Daytime) }
            />
        </ButtonPair>
    </div>
}


