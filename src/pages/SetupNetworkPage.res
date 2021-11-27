
/** ****************************************************************************
 * SetupNetworkPage
 */

open Types

let p = "[SetupNetworkPage] "

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {
    let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let modusOperandi = switch gameState.gameType {
        | StandAlone => <>
                <p> {React.string(t("You may host a game so that people can join from another smartphone."))} </p>
                <Spacer />
                <Button
                    label={t("Start Hosting")}
                    className="condensed-fr"
                    onClick={ _event => goToPage(_prev => SetupMaster) }
                />
                <p> {React.string(t("You can join a game running on another smartphone."))} </p>
                <Button
                    label={t("Join Game")}
                    onClick={ _event => goToPage(_prev => SetupSlave) }
                />
            </>
        | Master => <></>
        | Slave(_id) => <></>
    }


    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <BackFloatingButton onClick={(_event) => goToPage(_prev => returnPage)} />
        <GearFloatingButton goToPage returnPage=SetupNetwork />
        <h1 className="condensed-es" >
            {React.string(t("Multi-Telephone"))}
        </h1>
        <Spacer />
        {modusOperandi}
    </div>
}

