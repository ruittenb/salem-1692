/* *****************************************************************************
 * HostingIcon
 */

@react.component
let make = (): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)
  let (dbConnectionStatus, _setDbConnectionStatus) = React.useContext(DbConnectionContext.context)

  let isConnected = Utils.isConnected(dbConnectionStatus)

  switch gameState.gameType {
  | StandAlone => React.null
  | Master(_) => <div className="topbar-button icon-host" />
  | Slave(_) =>
    <If condition={isConnected}>
      <div className="topbar-button-40 icon-guest" />
    </If>
  }
}
