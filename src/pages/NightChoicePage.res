/* *****************************************************************************
 * NightChoicePage
 */

open Types
open PlayerCodec

let p = "[NightChoicePage] "

@react.component
let make = (
  ~addressed: addressed,
  ~choiceProcessor: (PlayerCodec.t, ~skipConfirmation: bool) => unit,
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
    Utils.logDebugGreen(p ++ "Mounted")
    // This serves two purposes:
    // 1. determine which database key to install the listener on;
    // 2. clear any previous choice that was recorded. (NightScenarioPage
    // has an effect hook that saves it to the database).
    let subject = switch addressed {
    | Witch
    | Witches => {
        Utils.logDebug(p ++ "Clearing witches' choice from turn state...")
        setTurnState(_prevTurnState => {
          ...turnState,
          choiceWitches: Undecided,
        })
        ChoiceWitchesSubject
      }
    | Constable => {
        Utils.logDebug(p ++ "Clearing constable's choice from turn state...")
        setTurnState(_prevTurnState => {
          ...turnState,
          choiceConstable: Undecided,
        })
        ChoiceConstableSubject
      }
    }
    Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
      Utils.logDebug(p ++ "About to install choice listener")
      FirebaseClient.listen(
        dbConnection,
        gameId,
        subject,
        player => {
          switch player->Belt.Option.flatMap(
            p => p->Js.Json.string->PlayerCodec.t_decode->Utils.resultToOption,
          ) {
          | None => ()
          | Some(Undecided) => ()
          | Some(person) => choiceProcessor(person, ~skipConfirmation=false)
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
          Utils.logDebug(p ++ "About to remove choice listener")
          FirebaseClient.stopListening(dbConnection, gameId, subject)
        })
        Utils.logDebugBlue(p ++ "Unmounted")
      },
    )
  })

  let titleAndEyes = if turnState.nightType === Dawn {
    <h1> {React.string(t("Dawn"))} </h1>
  } else {
    <>
      <h1> {React.string(t("Night"))} </h1>
      <Eyes />
    </>
  }

  // Construct the core element for this page
  <>
    {titleAndEyes}
    <PlayerList addressed choiceProcessor />
  </>
}
