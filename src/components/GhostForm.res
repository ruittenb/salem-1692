/* *****************************************************************************
 * GhostForm
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (): React.element => {
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let documentUrl = switch gameState.language {
  | #en_US => "doc/Salem 1692 - Rules for 2-3 Players English.pdf"
  | #fr_FR => `doc/Salem 1692 - Rules for 2-3 Players French.pdf`
  | #uk_UA => `doc/Salem 1692 - Rules for 2-3 Players Ukrainian.pdf`
  | _ => "doc/Salem 1692 - Rules for 2-3 Players English.pdf"
  }

  let onClick: clickHandler = _event => {
    setGameState(prevGameState => {
      ...prevGameState,
      hasGhostPlayers: !prevGameState.hasGhostPlayers,
    })
  }

  <>
    <h2> {React.string(t("Ghost Players"))} </h2>
    <p>
      {React.string(
        t(`In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`),
      )}
      {React.string(" ")}
      {React.string(t("Also check the box below."))}
      {React.string(" ")}
      {React.string(t("Please consult the "))}
      <Link href=documentUrl text={t("rules for 2-3 players.")} />
    </p>
    <Spacer />
    <Button
      label={t("With Ghosts")}
      className={"condensed-es condensed-fr condensed-pt icon-left " ++ (
        gameState.hasGhostPlayers ? "icon-checked" : "icon-unchecked"
      )}
      onClick
    />
  </>
}
