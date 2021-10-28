
/** ****************************************************************************
 * SetupSlavePage
 */

open Types
open Types.FbDb

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (maybeDbConnection, _setDbConnection) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (freeToProceed, setFreeToProceed) = React.useState(_ => false)

    // how to update a field
    // https://firebase.google.com/docs/database/web/read-and-write#update_specific_fields

    let leaveAnyCurrentGame = (dbConnectionStatus: dbConnectionStatus, gameState: gameState) => {
        switch (dbConnectionStatus, gameState.gameType) {
            | (Connected(dbConnection), Slave(gameId)) => FirebaseClient.leaveGame(dbConnection, gameId) // TODO also disconnect
            | (_, _)                                   => ()
        }
    }

    let placeholder = "x00-x00-x00-x00"
    let defaultValue = switch gameState.gameType {
        | StandAlone    => ""
        | Master        => ""
        | Slave(gameId) => gameId
    }

    let onBlur = (event) => {
        let newGameId = ReactEvent.Focus.currentTarget(event)["value"]
        if (!GameId.isValid(newGameId)) {
            setFreeToProceed(_prev => false)
        } else {
            leaveAnyCurrentGame(maybeDbConnection, gameState)
            switch (maybeDbConnection) {
                | NotConnected            => Js.log("No connection")
                | Connecting              => Js.log("Connecting")
                | Connected(dbConnection) => FirebaseClient.joinGame(dbConnection, newGameId)
            }
            // also TODO: what if failure?
            setGameState(prevGameState => {
                {
                    ...prevGameState,
                    gameType: Slave(newGameId)
                }
            })
            setFreeToProceed(_prev => true)
        }
    }

    let onBack = (_event) => {
        leaveAnyCurrentGame(maybeDbConnection, gameState)
        setGameState(prevGameState => {
            {
                ...prevGameState,
                gameType: StandAlone
            }
        })
        goToPage(_prev => Title)
    }

    let onForward = (_event) => {
        goToPage(_prev => SetupSlave) // TODO
    }

    // component
    <div id="setup-slave-page" className="page flex-vertical">
        <BackFloatingButton onClick=onBack />
        <GearFloatingButton goToPage returnPage=SetupSlave />
        <h1 className="condensed-es" >
            {React.string(t("Join Game"))}
        </h1>
        <Spacer />
        <p> {React.string(t("It is possible to join a game running on another smartphone."))} </p>
        <p>
            {React.string(t(
                // needs backticks for unicode arrow
                `Take the other smartphone and look in the app under Settings → Host Game. ` ++
                "Then enter the game code here."
            ))}
        </p>
        <Spacer />
        <input type_="text" className="id-input" maxLength=15 defaultValue placeholder onBlur />
        <Spacer />
        // Back/Forward buttons
        <ButtonPair>
            <Button
                label={t("Back")}
                className="icon-left icon-back"
                onClick=onBack
            />
            <Button
                label={t("Next")}
                disabled={!freeToProceed}
                className="icon-right icon-forw condensed-nl"
                onClick=onForward
            />
        </ButtonPair>
    </div>
}


