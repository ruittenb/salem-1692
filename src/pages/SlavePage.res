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
            FirebaseClient.listen(dbConnection, gameId, GameSubject, (maybeDbRecordStr: option<string>) => {
                switch maybeDbRecordStr {
                    | None => {
                        Utils.logDebug(p ++ "Received null on listener")
                        goToPage(_prev => SetupNetworkNoGame)
                    }
                    | Some(dbRecordStr) => {
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
                                        nightType: dbRecord.masterNightType,
                                        choiceWitches: dbRecord.slaveChoiceWitches === "" ? None : Some(dbRecord.slaveChoiceWitches),
                                        choiceConstable: dbRecord.slaveChoiceConstable === "" ? None : Some(dbRecord.slaveChoiceConstable)
                                    }
                                })
                            }
                        }
                    }
                }
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                Utils.logDebug(p ++ "About to remove remove game listener")
                FirebaseClient.stopListening(dbConnection, gameId, GameSubject)
            })
            Utils.logDebugBlue(p ++ "Unmounted")
        })
    })

    let witchOrWitches: addressed = (turnState.nrWitches === One) ? Witch : Witches

    let pageWrapperId = switch (subPage, turnState.nightType) {
        | (DaytimeWaiting, _) => "daytime-waiting-page"
        | (_, Dawn)           => "dawn-page"
        | (_, Night)          => "night-page"
    }

    let choiceWitchProcessor = (player: player, ~skipConfirmation: bool) => {
        let _dummy = skipConfirmation
        setTurnState(prevTurnState => {
            { ...prevTurnState, choiceWitches: Some(player) }
        })
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            FirebaseClient.saveGameTurnState(
                dbConnection,
                gameId,
                turnState.nightType->NightTypeCodec.nightTypeToString,
                turnState.nrWitches->NumerusCodec.numerusToJs,
                player,
                turnState.choiceConstable->Belt.Option.getWithDefault(""),
            )
        })
    }

    let choiceConstableProcessor = (player: player, ~skipConfirmation: bool) => {
        let _dummy = skipConfirmation
        setTurnState(prevTurnState => {
            { ...prevTurnState, choiceConstable: Some(player) }
        })
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
            FirebaseClient.saveGameTurnState(
                dbConnection,
                gameId,
                turnState.nightType->NightTypeCodec.nightTypeToString,
                turnState.nrWitches->NumerusCodec.numerusToJs,
                turnState.choiceWitches->Belt.Option.getWithDefault(""),
                player,
            )
        })
    }

    let pageElement = switch subPage {
        | DaytimeWaiting        => <DaytimeWaitingPage goToPage />
        | NightWaiting          => <NightWaitingPage goToPage />
        | NightChoiceWitches    => <NightChoicePage
                                       addressed=witchOrWitches
                                       choiceProcessor=choiceWitchProcessor
                                   />
        | NightChoiceConstable  => <NightChoicePage
                                       addressed=Constable
                                       choiceProcessor=choiceConstableProcessor
                                   />
        | NightConfirmWitches   => <NightConfirmPage
                                       addressed=witchOrWitches
                                       confirmationProcessor={
                                           (decision) => {
                                               Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                                                   FirebaseClient.saveGameConfirmation(
                                                       dbConnection,
                                                       gameId,
                                                       ConfirmWitchesSubject,
                                                       decision,
                                                   )
                                               })
                                               goToPage(_prev => NightWaiting)
                                           }
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceWitches) }
                                   />
        | NightConfirmConstable => <NightConfirmPage
                                       addressed=Constable
                                       confirmationProcessor={
                                           (decision) => {
                                               Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                                                   FirebaseClient.saveGameConfirmation(
                                                       dbConnection,
                                                       gameId,
                                                       ConfirmConstableSubject,
                                                       decision,
                                                   )
                                               })
                                               goToPage(_prev => NightWaiting)
                                           }
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceConstable) }
                                   />
        | _                     => <DaytimeWaitingPage goToPage />
    }

    // component
    <div id={pageWrapperId} className="page flex-vertical">
        {pageElement}
    </div>
}

