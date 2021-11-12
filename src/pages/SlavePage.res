
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
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

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

    let witchOrWitches: addressed = if subPage === NightFirstOneWitch { Witch } else { Witches }

    let pageElement = switch subPage {
        | DaytimeWaiting        => <DaytimeWaitingPage goToPage />
        | NightWaiting          => <NightWaitingPage goToPage />
        | NightChoiceWitches    => <NightChoicePage
                                       addressed=witchOrWitches
                                       choiceProcessor={ (player) => () }
                                   />
        | NightChoiceConstable  => <NightChoicePage
                                       addressed=Constable
                                       choiceProcessor={ (player) => () }
                                   />
        | NightConfirmWitches   => <NightConfirmPage
                                       addressed=witchOrWitches
                                       confirmationProcessor={ (decision):unit => () }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceWitches) }
                                   />
        | NightConfirmConstable => <NightConfirmPage
                                       addressed=Constable
                                       confirmationProcessor={ (decision):unit => () }
                                       goToPrevStep={ () => goToPage(_prev => NightChoiceConstable) }
                                   />
        | _                     => <DaytimeWaitingPage goToPage />
    }

    // component
    {pageElement}
}

