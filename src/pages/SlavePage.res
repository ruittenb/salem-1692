
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
            //Utils.logDebug(p ++ "About to install game listener") // TODO
            //FirebaseClient.listen(dbConnection, gameId, GameSubject, (dbRecordStr: string) => {
            //    dbRecordStr
            //        ->dbRecordToJs
            //        //->Belt.Option.forEach(
            //        //    phase => goToPage(_prev => phase->FirebaseClient.getPage)
            //        //)
            //    ()
            //})
            Utils.logDebug(p ++ "About to install phase listener")
            FirebaseClient.listen(dbConnection, gameId, MasterPhaseSubject, (phaseStr: string) => {
                phaseStr
                    ->phaseFromJs
                    ->Belt.Option.forEach(
                        phase => goToPage(_prev => phase->FirebaseClient.getPage)
                    )
            })
            Utils.logDebug(p ++ "About to install players listener")
            FirebaseClient.listen(dbConnection, gameId, MasterPlayersSubject, (playersStr: string): unit => {
                let playersJson: option<array<string>> = playersStr
                    ->Js.Json.string
                    ->playersFromJson
                switch playersJson {
                    | Some(players) => setGameState(prevGameState => {
                                           { ...prevGameState, players }
                                       })
                    | None => ()
                }
            })
            Utils.logDebug(p ++ "About to install seating listener")
            FirebaseClient.listen(dbConnection, gameId, MasterSeatingSubject, (seatingStr: string): unit => {
                seatingStr
                    ->SeatingCodec.seatingFromJs
                    ->Belt.Option.forEach( seating => {
                        setGameState(prevGameState => {
                            { ...prevGameState, seating }
                        })
                    })
            })
            Utils.logDebug(p ++ "About to install numberWitches listener")
            FirebaseClient.listen(dbConnection, gameId, MasterNumberWitchesSubject, (numberWitchesStr: string) => {
                numberWitchesStr
                    ->nrWitchesFromJs
                    ->Utils.resultForEach(nrWitches => {
                        setTurnState(prevTurnState => {
                            { ...prevTurnState, nrWitches }
                        })
                    })
            })
        })
        Some(() => { // Cleanup: remove listener
            Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
                Utils.logDebug(p ++ "About to remove remove listeners")
                FirebaseClient.stopListening(dbConnection, gameId, MasterPhaseSubject)
                FirebaseClient.stopListening(dbConnection, gameId, MasterPlayersSubject)
                FirebaseClient.stopListening(dbConnection, gameId, MasterSeatingSubject)
                FirebaseClient.stopListening(dbConnection, gameId, MasterNumberWitchesSubject)
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
                                               goToPage(_prev => NightConfirmConstable)
                                           }
                                       }
                                   />
        | NightConfirmWitches   => <NightConfirmPage
                                       addressed=witchOrWitches
                                       confirmationProcessor={
                                           (decision): unit => Utils.logDebug("confirmationProcessor for witches")
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceWitches) }
                                   />
        | NightConfirmConstable => <NightConfirmPage
                                       addressed=Constable
                                       confirmationProcessor={
                                           (decision): unit => Utils.logDebug("confirmationProcessor for constable")
                                       }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceConstable) }
                                   />
        | _                     => <DaytimeWaitingPage goToPage />
    }

    // component
    {pageElement}
}

