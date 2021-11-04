
/** ****************************************************************************
 * NightChoicePage
 */

open Types

@react.component
let make = (
    ~addressed: addressed,
    ~choiceProcessor: (player) => unit,
): React.element => {

    // db connection status
    let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    // turn state
    let (turnState, setTurnState) = React.useContext(TurnStateContext.context)
    // translator, game state
    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // Runs only once right after mounting the component
    React.useEffect0(() => {
        Utils.logDebug2("Mounted ChoicePage", "font-weight: bold")
        // This serves two purposes:
        // 1. determine which database key to install the listener on;
        // 2. clear any previous choice that was recorded. (NightScenarioPage
        // has an effect hook that saves it to the database).
        let subject = switch addressed {
            | Witch | Witches => {
                                     Utils.logDebug("Clearing witches' choice from turn state...")
                                     setTurnState(_prevTurnState => {
                                         ...turnState,
                                         choiceWitches: None,
                                     })
                                     Types.FbDb.ChoiceWitches
                                 }
            | Constable       => {
                                     Utils.logDebug("Clearing constable's choice from turn state...")
                                     setTurnState(_prevTurnState => {
                                         ...turnState,
                                         choiceConstable: None,
                                     })
                                     Types.FbDb.ChoiceConstable
                                 }
        }
        Utils.ifMasterAndConnected(
            gameState.gameType,
            dbConnectionStatus,
            (dbConnection) => {
                Utils.logDebug("About to install choice listener")
                FirebaseClient.listen(
                    dbConnection,
                    gameState.gameId,
                    subject,
                    (player) => {
                        if player !== "" { choiceProcessor(player) } else { () }
                    },
                )
            }
        )
        Some(() => { // Cleanup: remove listener
            Utils.logDebug("Unmounting ChoicePage")
            Utils.ifMasterAndConnected(
                gameState.gameType,
                dbConnectionStatus,
                (dbConnection) => {
                    Utils.logDebug("About to remove choice listener")
                    FirebaseClient.stopListening(
                        dbConnection,
                        gameState.gameId,
                        subject,
                    )
                }
            )
        })
    })

    // Construct the core element for this page
    <div id="night-page" className="page">
        <div id="night-subpage" className="page flex-vertical">
            <h1> {React.string(t("Night"))} </h1>
            // vertically step past background eyes
            <Spacer />
            <Spacer />
            <Spacer />
            <PlayerList addressed choiceProcessor />
        </div>
    </div>
}

