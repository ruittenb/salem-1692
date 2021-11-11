
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
        <p className="text-centered"> {React.string(t("Waiting for the host to announce nighttime..."))} </p>
        <Spacer />
        <Button
            label={t("Abort")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => SetupSlave) }
        />
    </div>
}

