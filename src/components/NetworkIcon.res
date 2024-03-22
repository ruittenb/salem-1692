/* *****************************************************************************
 * HostingIcon
 */

@react.component
let make = (): React.element => {
  let (gameState, _setGameState) = React.useContext(GameStateContext.context)

  switch gameState.gameType {
  | Master(_) => <div className="topbar-button icon-host" />
  | Slave(_) => <div className="topbar-button-40 icon-guest" />
  | StandAlone => React.null
  }
}
