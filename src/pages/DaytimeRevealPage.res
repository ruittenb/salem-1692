
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

    let (witchVictimPlayer,   _): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.contextWitch)
    let (constableSavePlayer, _): (string, chosenPlayerSetter) = React.useContext(ChosenPlayerContext.contextConstable)

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("The Reveal"))} </h1>
        <Spacer />
        <LargeButton onClick={ _event => goToPage(_prev => Daytime) } >
            {React.string(t("Reveal witches' victim"))}
        </LargeButton>
        <LargeButton onClick={ _event => goToPage(_prev => FirstNightMoreWitches) } >
            {React.string(t("Reveal constable's protection"))}
        </LargeButton>
        <Spacer />
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


