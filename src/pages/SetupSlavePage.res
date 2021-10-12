
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

    let freeToProceed = true // TODO  GameId.isValid()

    let placeholder = "x00-x00-x00-x00"
    let defaultValue = switch gameState.gameType {
        | StandAlone    => ""
        | Master(_)     => ""
        | Slave(gameId) => gameId
    }

    let onBlur = (_) => {
        goToPage(_prev => Title) // TODO
    }

    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <SettingsGear goToPage returnPage=SetupSlave />
        <h1 className="condensed-es" >
            {React.string(t("Join Game"))}
        </h1>
        <Spacer />
        <div className="paragraph">
            {React.string(t("It is possible to join a game running on another smartphone."))}
            <br />
            <br />
            {React.string(t(
                `Take the other smartphone and look in the app under Settings → Game ID. ` ++ // need backticks for arrow
                "Then enter the Game ID here."
            ))}
        </div>
        <Spacer />
        <input type_="text" className="id-input" defaultValue placeholder onBlur />
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


