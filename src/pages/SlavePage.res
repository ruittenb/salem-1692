/** ****************************************************************************
 * SlavePage
 */

open Types

let p = "[SlavePage] "

@react.component
let make = (
    ~goToPage,
    ~subPage: page,
): React.element => {
    let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    // turn state
    let (turnState, setTurnState) = React.useContext(TurnStateContext.context)

    React.useEffect0(() => {
        Utils.logDebugGreen(p ++ "Mounted")
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            Utils.logDebug(p ++ "About to install game listener")
            FirebaseClient.listen(dbConnection, gameId, GameSubject, (dbRecordStr: string) => {
                switch (dbRecordStr->Js.Json.string->dbRecord_decode) {
                    | Error(deccoError) => {
                        Utils.logError(
                            deccoError.path ++ ": " ++ deccoError.message ++ ": " ++
                            deccoError.value->Js.Json.decodeString->Belt.Option.getWithDefault("<None>")
                        )
                    }
                    | Ok(dbRecord) => {
                        Utils.logDebug(p ++ "Received dbRecord")
                        goToPage(_prev => dbRecord.masterPhase->FirebaseClient.getPage)
                        setGameState(prevGameState => {
                            {
                                ...prevGameState,
                                players: dbRecord.masterPlayers,
                                seating: dbRecord.masterSeating
                            }
                        })
                        setTurnState(_prevTurnState => {
                            {
                                nrWitches: dbRecord.masterNumberWitches,
                                choiceWitches: dbRecord.slaveChoiceWitches === "" ? None : Some(dbRecord.slaveChoiceWitches),
                                choiceConstable: dbRecord.slaveChoiceConstable === "" ? None : Some(dbRecord.slaveChoiceConstable)
                            }
                        })
                    }
                }
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                Utils.logDebug(p ++ "About to remove remove game listener")
                FirebaseClient.stopListening(dbConnection, gameId, GameSubject)
            })
            Utils.logDebugRed(p ++ "Unmounted")
        })
    })

    let witchOrWitches: addressed = if (turnState.nrWitches === One) { Witch } else { Witches }

    let pageElement = switch subPage {
        | DaytimeWaiting        => <DaytimeWaitingPage goToPage />
        | NightWaiting          => <NightWaitingPage goToPage />
        | NightChoiceWitches    => <NightChoicePage
                                       addressed=witchOrWitches
                                       choiceProcessor={
                                           (player) => {
                                               setTurnState(prevTurnState => {
                                                   { ...prevTurnState, choiceWitches: Some(player) }
                                               })
                                               Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                                                   FirebaseClient.saveGameTurnState(
                                                       dbConnection,
                                                       gameId,
                                                       turnState.nrWitches->NumerusCodec.numerusToJs,
                                                       player,
                                                       turnState.choiceConstable->Belt.Option.getWithDefault(""),
                                                   )
                                               })
                                               goToPage(_prev => NightConfirmWitches)
                                           }
                                       }
                                   />
        | NightChoiceConstable  => <NightChoicePage
                                       addressed=Constable
                                       choiceProcessor={
                                           (player) => {
                                               setTurnState(prevTurnState => {
                                                   { ...prevTurnState, choiceConstable: Some(player) }
                                               })
                                               Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                                                   FirebaseClient.saveGameTurnState(
                                                       dbConnection,
                                                       gameId,
                                                       turnState.nrWitches->NumerusCodec.numerusToJs,
                                                       turnState.choiceWitches->Belt.Option.getWithDefault(""),
                                                       player,
                                                   )
                                               })
                                               goToPage(_prev => NightConfirmConstable)
                                           }
                                       }
                                   />
        | NightConfirmWitches   => <NightConfirmPage
                                       addressed=witchOrWitches
                                       confirmationProcessor={
                                           (_decision) => {
                                               goToPage(_prev => NightWaiting)
                                           }
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceWitches) }
                                   />
        | NightConfirmConstable => <NightConfirmPage
                                       addressed=Constable
                                       confirmationProcessor={
                                           (_decision) => {
                                               goToPage(_prev => NightWaiting)
                                           }
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceConstable) }
                                   />
        | _                     => <DaytimeWaitingPage goToPage />
    }

    // component
    {pageElement}
}

