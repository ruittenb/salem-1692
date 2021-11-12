
/** ****************************************************************************
 * DaytimeWaitingPage
 */

open Types

let p = "[DaytimeWaitingPage] "

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // TODO Split this into SlaveScenarioPage and all subpages
    React.useEffect0(() => {
        Utils.logDebugGreen(p ++ "Mounted")
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            Utils.logDebug(p ++ "About to install phase listener")
            FirebaseClient.listen(dbConnection, gameId, MasterPhaseSubject, (phaseString) => {
                phaseString
                    ->Types.FbDb.phaseFromJs
                    ->Belt.Option.forEach(
                        phase => goToPage(_prev => phase->FirebaseClient.getPage)
                    )
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                Utils.logDebug(p ++ "About to remove remove listener")
                FirebaseClient.stopListening(dbConnection, gameId, MasterPhaseSubject)
            })
            Utils.logDebugRed(p ++ "Unmounted")
        })
    })

    // component
    <div id="daytime-waiting-page" className="page flex-vertical">
        <h1> {React.string(t("Daytime"))} </h1>
        <p className="text-centered"> {React.string(t("Waiting for the host to announce nighttime..."))} </p>
        <Spacer />
        <Button
            label={t("Abort")}
            className="icon-left icon-abort"
            onClick={ _event => goToPage(_prev => SetupSlave) }
        />
    </div>
}

