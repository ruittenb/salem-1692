
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

    let witchesRevealPrompt = if turnState.nrWitches === 1 {
        t("Reveal witch's victim")
    } else {
        t("Reveal witches' victim")
    }
    let witchesRevelationPrompt = if turnState.nrWitches === 1 {
        t("The witch attacked")
    } else {
        t("The witches attacked")
    }

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("The Reveal"))} </h1>
        <Spacer />
        <LargeRevealButton
            revealPrompt=witchesRevealPrompt
            revelationPrompt=witchesRevelationPrompt
            secret=turnState.choiceWitches
        />
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
        <ButtonPair>
            <Button
                label={t("Back")}
                className="icon_left icon_back"
                onClick={ _event => goToPage(_prev => DaytimeConfess) }
            />
            <Button
                label={t("Next")}
                className="icon_right icon_forw"
                onClick={ _event => goToPage(_prev => Daytime) }
            />
        </ButtonPair>
    </div>
}


