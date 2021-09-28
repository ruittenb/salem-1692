
/** ****************************************************************************
 * SetupSlavePage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let freeToProceed = true // TODO whether a valid game ID has been entered

    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <SettingsGear goToPage returnPage=SetupSlave />
        <h1 className="condensed-es" >
            {React.string(t("Join Game"))}
        </h1>
        <Spacer />
        <div className="paragraph">
            {React.string(t("It is possible to join a game running on another telephone."))}
            <br />
            <br />
            {React.string(t(`Take the other telephone and look in the app under Settings → Game ID. Then enter the Game ID here.`))}
        </div>
        <Spacer />
        // Back/Forward buttons
        <ButtonPair>
            <Button
                label={t("Back")}
                className="icon-left icon-back"
                onClick={ _event => goToPage(_prev => Title) }
            />
            <Button
                label={t("Next")}
                disabled={!freeToProceed}
                className="icon-right icon-forw condensed-nl"
                onClick={ _event => () /* TODO goToPage(_prev => Title) */ }
            />
        </ButtonPair>
    </div>
}


