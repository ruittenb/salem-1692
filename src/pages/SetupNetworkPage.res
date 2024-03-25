/* *****************************************************************************
 * SetupNetworkPage
 */

open Types
open Utils

@get external getValue: Dom.element => string = "value"
@set external setValue: (Dom.element, string) => unit = "value"

let pm = "[SetupNetworkPage:Master] "
let ps = "[SetupNetworkPage:Slave] "

let inputElementId = "formGameId"

/* *****************************************************************************
 * Master functions
 */
let startHosting = (setDbConnectionStatus, gameState, setGameState) => {
  logDebug(pm ++ "Starting hosting")
  setDbConnectionStatus(_prev => ConnectingAsMaster)
  let oldGameState = gameState
  FirebaseClient.connect()
  ->Promise.then(dbConnection => {
    let newGameId = GameId.generateGameId()
    let newGameState = {
      ...gameState,
      gameType: Master(newGameId),
    }
    setGameState(_prev => newGameState)
    FirebaseClient.createGame(dbConnection, newGameState)->Promise.then(() => {
      setDbConnectionStatus(_prev => Connected(dbConnection))
      Promise.resolve()
    })
  })
  ->Promise.catch(error => {
    setGameState(_prev => oldGameState)
    setDbConnectionStatus(_prev => NotConnected)
    error->Utils.getExceptionMessage->Utils.logError
    Promise.resolve()
  })
  ->ignore
}

let stopHosting = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
  Utils.ifMasterAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
    logDebug(pm ++ "Stopping hosting")
    FirebaseClient.deleteGame(dbConnection, gameId)
    FirebaseClient.disconnect(dbConnection)
  })
  setDbConnectionStatus(_prev => NotConnected)
  setGameState(prevGameState => {
    ...prevGameState,
    gameType: StandAlone,
  })
}

/* *****************************************************************************
 * Slave functions
 */

let joinGame = (setDbConnectionStatus, setGameState, newGameId, callback) => {
  logDebug(ps ++ "Joining game " ++ newGameId)
  setDbConnectionStatus(_prev => ConnectingAsSlave)
  FirebaseClient.connect()
  ->Promise.then(dbConnection => {
    setGameState(prevGameState => {
      ...prevGameState,
      gameType: Slave(newGameId),
    })
    setDbConnectionStatus(_prev => Connected(dbConnection))
    let connectSuccess: bool = FirebaseClient.joinGame(dbConnection, newGameId)
    callback(connectSuccess)
    Promise.resolve()
  })
  ->Promise.catch(error => {
    setGameState(prevGameState => {
      ...prevGameState,
      gameType: StandAlone,
    })
    setDbConnectionStatus(_prev => NotConnected)
    error->Utils.getExceptionMessage->Utils.logError
    callback(false)
    Promise.resolve()
  })
  ->ignore
}

let leaveGame = (dbConnectionStatus, setDbConnectionStatus, gameState, setGameState) => {
  Utils.ifSlaveAndConnected(dbConnectionStatus, gameState.gameType, (dbConnection, gameId) => {
    logDebug(ps ++ "Leaving game " ++ gameId)
    FirebaseClient.leaveGame(dbConnection, gameId)
    FirebaseClient.disconnect(dbConnection)
  })
  setDbConnectionStatus(_prev => NotConnected)
  setGameState(prevGameState => {
    ...prevGameState,
    gameType: StandAlone,
  })
}

let tryPlayAsSlave = (
  goToPage,
  dbConnectionStatus,
  setDbConnectionStatus,
  gameState,
  setGameState,
  setSlaveGameIdValidity,
) => {
  let newGameId = Utils.safeQuerySelector(inputElementId)->Belt.Result.mapWithDefault("", getValue)
  if !GameId.isValid(newGameId) {
    // Code is not valid
    logDebug(ps ++ "Code " ++ newGameId ++ " is not valid")
    leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
    setSlaveGameIdValidity(_prev => SlaveInputShownAndInvalid)
  } else {
    // Code is valid
    logDebug(ps ++ "Code " ++ newGameId ++ " is valid")
    setSlaveGameIdValidity(_prev => SlaveInputShown)
    // We should always disconnect so that we won't have multiple listeners
    leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
    joinGame(setDbConnectionStatus, setGameState, newGameId, isSuccess =>
      if isSuccess {
        goToPage(_prev => DaytimeWaiting)
      } else {
        setSlaveGameIdValidity(_prev => SlaveInputShownAndAbsent)
      }
    )
  }
}

/* *****************************************************************************
 * Page functions
 */

let getModusOperandi = (
  t,
  goToPage,
  gameState,
  setGameState,
  dbConnectionStatus,
  setDbConnectionStatus,
  slaveGameIdValidity,
  setSlaveGameIdValidity,
) =>
  switch (gameState.gameType, dbConnectionStatus, slaveGameIdValidity) {
  | (StandAlone, _, SlaveInputHidden) =>
    <>
      <h2> {React.string(t("Play as Host"))} </h2>
      <p>
        {React.string(t("You can host a game so that players can join from another smartphone."))}
      </p>
      <Spacer />
      <Button
        label={t("Start Hosting")}
        className="condensed-fr condensed-pt"
        onClick={_event => startHosting(setDbConnectionStatus, gameState, setGameState)}
      />
      <Rule />
      <h2> {React.string(t("Play as Guest"))} </h2>
      <p> {React.string(t("You can join a game running on another smartphone."))} </p>
      <Spacer />
      <Button
        label={t("Join Game")}
        className="condensed-it condensed-uk condensed-ko"
        onClick={_event => setSlaveGameIdValidity(_prev => SlaveInputShown)}
      />
    </>
  | (Master(_), NotConnected, _) =>
    <>
      // Should never happen: we should be connected before we set the game type to Master
      <Spacer />
      <Button
        label={t("Start Hosting")}
        className="condensed-fr"
        onClick={_event => startHosting(setDbConnectionStatus, gameState, setGameState)}
      />
    </>
  | (Master(_), ConnectingAsSlave, _) // should not happen
  | (_, ConnectingAsMaster, _) =>
    <>
      <Spacer />
      <div className="bubble"> {React.string(t("Connecting..."))} </div>
      // TODO add abort connecting button
    </>
  | (Master(gameId), Connected(_), _) =>
    <>
      <h2> {React.string(t("Play as Host"))} </h2>
      <p>
        {React.string(t("You are currently hosting a game.") ++ " ")}
        {React.string(
          t(
            // needs backticks for unicode arrow
            `Take the other smartphone and look in the app under Multi-Telephone → Play as Guest. ` ++ "Then enter the following game code there.",
          ),
        )}
      </p>
      <Spacer />
      <div className="input-and-icon">
        <div className="id-input"> {React.string(gameId)} </div>
        <QrIcon mode={QrIcon.Scannable(gameId)} />
        <div className="bubble north"> {React.string(t("Connected."))} </div>
      </div>
      <Button
        label={t("Play Game")}
        className="icon-right icon-forw condensed-nl"
        onClick={_event => goToPage(_prev => Daytime)}
      />
      <Button
        label={t("Stop Hosting")}
        className="condensed-nl condensed-uk ultra-condensed-ko"
        onClick={_event =>
          stopHosting(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)}
      />
      <Rule />
      <h2> {React.string(t("Play as Guest"))} </h2>
      <p> {React.string(t("If you want to join a running game, you must stop hosting first."))} </p>
      <Spacer />
    </>
  | (StandAlone, dbConnectionStatus, slaveGameIdValidity)
  | (Slave(_), dbConnectionStatus, slaveGameIdValidity) =>
    <>
      <h2> {React.string(t("Play as Guest"))} </h2>
      <p>
        {React.string(
          t(
            // needs backticks for unicode arrow
            `Take the other smartphone and look in the app under Multi-Telephone → Play as Host. ` ++ "Then enter the game code here.",
          ),
        )}
      </p>
      <Spacer />
      <div className="input-and-icon">
        <input
          type_="text"
          id={inputElementId}
          className="id-input"
          maxLength=15
          placeholder="x00-x00-x00-x00"
          defaultValue={gameState.gameType->Utils.ifSlaveGetGameId}
          onChange={_event => {
            leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
            setSlaveGameIdValidity(_prev => SlaveInputShown)
          }}
        />
        <QrIcon
          mode={QrIcon.Scanner(
            scannedGameId => {
              Utils.safeQuerySelector(inputElementId)->Utils.resultForEach(inputElement => {
                inputElement->setValue(scannedGameId)
                setSlaveGameIdValidity(_prev => SlaveInputShown)
                setDbConnectionStatus(_prev => NotConnected)
              })
            },
          )}
        />
      </div>
      {
        let slaveConnectionStatus = switch (dbConnectionStatus, slaveGameIdValidity) {
        | (NotConnected, SlaveInputHidden) // should not happen
        | (NotConnected, SlaveInputShown) => "Not connected"
        | (NotConnected, SlaveInputShownAndInvalid) => "Malformed code"
        | (NotConnected, SlaveInputShownAndAbsent) => "Game not found"
        | (ConnectingAsMaster, _) // should not happen
        | (ConnectingAsSlave, _) => "Connecting..."
        | (Connected(_), SlaveInputShownAndAbsent) => "Game not found"
        | (Connected(_), _) => "Connected."
        }
        <div className="bubble north"> {React.string(t(slaveConnectionStatus))} </div>
      }
      // Back/Forward buttons
      <Button
        label={t("Play Game")}
        className="icon-right icon-forw condensed-nl"
        onClick={_event =>
          tryPlayAsSlave(
            goToPage,
            dbConnectionStatus,
            setDbConnectionStatus,
            gameState,
            setGameState,
            setSlaveGameIdValidity,
          )}
      />
      <Button
        label={t("Leave guest mode")}
        className="condensed-es condensed-fr ultra-condensed-pt ultra-condensed-it condensed-de ultra-condensed-uk ultra-condensed-ko"
        onClick={_event => {
          leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
          setSlaveGameIdValidity(_prev => SlaveInputHidden)
        }}
      />
      <Rule />
      <h2> {React.string(t("Play as Host"))} </h2>
      <p>
        {React.string(
          t(
            "If you want to host a game so that others can join, you should leave guest mode first.",
          ),
        )}
      </p>
      <Spacer />
    </>
  }

/* *****************************************************************************
 * React Component
 */
@react.component
let make = (~goToPage, ~noGame): React.element => {
  let (dbConnectionStatus, setDbConnectionStatus) = React.useContext(DbConnectionContext.context)
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let (slaveGameIdValidity, setSlaveGameIdValidity) = React.useState(_ =>
    noGame ? SlaveInputShownAndAbsent : SlaveInputHidden
  )

  let modusOperandi = getModusOperandi(
    t,
    goToPage,
    gameState,
    setGameState,
    dbConnectionStatus,
    setDbConnectionStatus,
    slaveGameIdValidity,
    setSlaveGameIdValidity,
  )

  // component
  <div id="setup-network-page" className="page justify-start">
    <TopBar
      goToPage
      returnPage=Some(SetupNetwork)
      onBack={Some(
        _event => {
          leaveGame(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
          stopHosting(dbConnectionStatus, setDbConnectionStatus, gameState, setGameState)
          goToPage(_prev => Title)
        },
      )}
    />
    <h1> {React.string(t("Multi-Telephone"))} </h1>
    {modusOperandi}
  </div>
}
