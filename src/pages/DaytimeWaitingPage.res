
/** ****************************************************************************
 * DaytimeWaitingPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // component
    <div id="daytime-waiting-page" className="page flex-vertical">
        <GearFloatingButton goToPage returnPage=DaytimeWaiting />
        <h1> {React.string(t("Daytime"))} </h1>
        <p> {React.string(t("Waiting for host to signal nighttime..."))} </p>
        <Spacer />
        <Button
            label={t("Leave")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => SetupSlave) }
        />
    </div>
}

