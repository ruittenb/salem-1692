/* *****************************************************************************
 * NightConfirmPage
 */

// @@warning("-33") // Unused 'open Types'

open Types
open PlayerCodec

let p = "[NightConfirmPage] "

@react.component
let make = (~addressed: addressed, ~confirmationProcessor, ~goToPrevStep): React.element => {
  // db connection status
  let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
  // turn state
  let (turnState, _setTurnState) = React.useContext(TurnStateContext.context)
  // translator, game state
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let question = switch addressed {
  | Witch => t("Witch, are you sure?")
  | Witches => t("Witches, are you sure?")
  | Constable => t("Constable, are you sure?")
  }
  let choice = switch addressed {
  | Witch
  | Witches =>
    turnState.choiceWitches->playerTypeToLocalizedString(t)
  | Constable => turnState.choiceConstable->playerTypeToLocalizedString(t)
  }

  // Runs only once right after mounting the component
  React.useEffect0(() => {
    Utils.logDebugGreen(
      p ++
      "Mounted; choiceWitches:" ++
      turnState.choiceWitches->playerTypeToString ++
      " choiceConstable:" ++
      turnState.choiceConstable->playerTypeToString,
    )
    // At this point we should have a choice to ask confirmation for.
    // Therefore, these situations should never happen.
    switch addressed {
    | Witch if turnState.choiceWitches === Undecided => goToPrevStep()
    | Witches if turnState.choiceWitches === Undecided => goToPrevStep()
    | Constable if turnState.choiceConstable === Undecided => goToPrevStep()
    | _ => ()
    }
    let subject = switch addressed {
    | Witch | Witches => {
        Utils.logDebug(p ++ "Clearing witches' confirmation from turn state...")
        Types.ConfirmWitchesSubject
      }
    | Constable => {
        Utils.logDebug(p ++ "Clearing constable's confirmation from turn state...")
        Types.ConfirmConstableSubject
      }
    }
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      // clear any previous confirmation that was recorded
      FirebaseClient.saveGameConfirmation(dbConnection, gameId, subject, Unconfirmed)

      // install new listener
      Utils.logDebug(p ++ "About to install confirmation listener")
      FirebaseClient.listen(
        dbConnection,
        gameId,
        subject,
        maybeDecision => {
          switch maybeDecision {
          | Some("Yes") => confirmationProcessor(Yes)
          | Some("No") => confirmationProcessor(No)
          | Some(_) => ()
          | None => ()
          }
        },
      )
    })
    Some(
      () => {
        // Cleanup: remove listener
        Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (
          dbConnection,
          gameId,
        ) => {
          Utils.logDebug(p ++ "About to remove confirmation listener")
          FirebaseClient.stopListening(dbConnection, gameId, subject)
        })
        Utils.logDebugBlue(p ++ "Unmounted")
      },
    )
  })

  let eyesImage = turnState.nightType === Dawn ? React.null : <Eyes />

  // component
  <div id="night-confirm-page" className="page justify-start">
    <h1> {React.string(t("Confirm"))} </h1>
    {eyesImage}
    {React.string(question)}
    <br />
    <h2> {React.string(choice)} </h2>
    <Spacer />
    <Spacer />
    <LargeButton
      className="confirm-yes" title={t("Yes")} onClick={_event => confirmationProcessor(Yes)}
    />
    <Spacer />
    <LargeButton
      className="confirm-no" title={t("No")} onClick={_event => confirmationProcessor(No)}
    />
    <Spacer />
  </div>
}
