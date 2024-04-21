/* *****************************************************************************
 * SlavePage
 */

open Types

let p = "[SlavePage] "

@react.component
let make = (~subPage: page): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  // turn state
  let (turnState, setTurnState) = React.useContext(TurnStateContext.context)

  React.useEffect0(() => {
    Utils.logDebugGreen(p ++ "Mounted")
    Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      Utils.logDebug(p ++ "About to install game listener")
      FirebaseClient.listen(
        dbConnection,
        gameId,
        GameSubject,
        (maybeDbRecordStr: option<string>) => {
          switch maybeDbRecordStr {
          | None => {
              Utils.logDebug(p ++ "Received null on listener")
              setDbConnectionStatus(_prev => NotConnected)
              goToPage(_prev => SetupNetworkNoGame)
            }
          | Some(dbRecordStr) =>
            switch dbRecordStr->Js.Json.string->dbRecord_decode {
            | Error(spiceError) =>
              Utils.logError(
                spiceError.path ++
                ": " ++
                spiceError.message ++
                ": " ++
                spiceError.value->Js.Json.decodeString->Belt.Option.getWithDefault("<None>"),
              )
            | Ok(dbRecord) => {
                Utils.logDebug(p ++ "Received dbRecord")
                goToPage(_prev => dbRecord.masterPhase->FirebaseClient.getPage)
                setGameState(
                  prevGameState => {
                    {
                      ...prevGameState,
                      players: dbRecord.masterPlayers,
                      seating: dbRecord.masterSeating,
                      hasGhostPlayers: dbRecord.masterHasGhostPlayers,
                    }
                  },
                )
                setTurnState(
                  _prevTurnState => {
                    {
                      nrWitches: dbRecord.masterNumberWitches,
                      nightType: dbRecord.masterNightType,
                      choiceWitches: dbRecord.slaveChoiceWitches,
                      choiceConstable: dbRecord.slaveChoiceConstable,
                    }
                  },
                )
              }
            }
          }
        },
      )
    })
    Some(
      () => {
        // Cleanup: remove listener
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (
          dbConnection,
          gameId,
        ) => {
          Utils.logDebug(p ++ "About to remove game listener")
          FirebaseClient.stopListening(dbConnection, gameId, GameSubject)
        })
        Utils.logDebugBlue(p ++ "Unmounted")
      },
    )
  })

  let witchOrWitches: addressed = turnState.nrWitches === One ? Witch : Witches

  let pageWrapperId = switch (subPage, turnState.nightType) {
  | (DaytimeWaiting, _) => "daytime-waiting-page"
  | (_, Dawn) => "dawn-page"
  | (_, Night) => "night-page"
  }

  let choiceWitchProcessor = (player: PlayerCodec.t, ~skipConfirmation: bool) => {
    let _dummy = skipConfirmation
    setTurnState(prevTurnState => {
      {...prevTurnState, choiceWitches: player}
    })
    Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      FirebaseClient.saveGameTurnState(
        dbConnection,
        gameId,
        turnState.nightType->NightTypeCodec.nightTypeToString,
        turnState.nrWitches->NumerusCodec.numerusToJs,
        player->PlayerCodec.playerTypeToString,
        turnState.choiceConstable->PlayerCodec.playerTypeToString,
      )
    })
  }

  let choiceConstableProcessor = (player: PlayerCodec.t, ~skipConfirmation: bool) => {
    let _dummy = skipConfirmation
    setTurnState(prevTurnState => {
      {...prevTurnState, choiceConstable: player}
    })
    Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      FirebaseClient.saveGameTurnState(
        dbConnection,
        gameId,
        turnState.nightType->NightTypeCodec.nightTypeToString,
        turnState.nrWitches->NumerusCodec.numerusToJs,
        turnState.choiceWitches->PlayerCodec.playerTypeToString,
        player->PlayerCodec.playerTypeToString,
      )
    })
  }

  let pageElement = switch subPage {
  | DaytimeWaiting => <DaytimeWaitingPage />
  | NightWaiting => <NightWaitingPage />
  | NightChoiceWitches =>
    <NightChoicePage addressed=witchOrWitches choiceProcessor=choiceWitchProcessor />
  | NightChoiceConstable =>
    <NightChoicePage addressed=Constable choiceProcessor=choiceConstableProcessor />
  | NightConfirmWitches =>
    <NightConfirmPage
      addressed=witchOrWitches
      confirmationProcessor={confirmation => {
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (
          dbConnection,
          gameId,
        ) => {
          FirebaseClient.saveGameConfirmation(
            dbConnection,
            gameId,
            ConfirmWitchesSubject,
            confirmation,
          )
        })
        goToPage(_prev => NightWaiting)
      }}
      goToPrevStep={() => goToPage(_prev => NightChoiceWitches)}
    />
  | NightConfirmConstable =>
    <NightConfirmPage
      addressed=Constable
      confirmationProcessor={confirmation => {
        Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (
          dbConnection,
          gameId,
        ) => {
          FirebaseClient.saveGameConfirmation(
            dbConnection,
            gameId,
            ConfirmConstableSubject,
            confirmation,
          )
        })
        goToPage(_prev => NightWaiting)
      }}
      goToPrevStep={() => goToPage(_prev => NightChoiceConstable)}
    />
  | _ => <DaytimeWaitingPage />
  }

  // component
  <div id={pageWrapperId} className="page justify-start"> {pageElement} </div>
}
