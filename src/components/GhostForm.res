/** ****************************************************************************
 * GhostForm
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (): React.element => {
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let onClick: clickHandler = (_event) => {
        setGameState(prevGameState => {
            ...prevGameState,
            hasGhostPlayers: !prevGameState.hasGhostPlayers,
        })
    }

    <>
        <h2> {React.string(t("Ghost Players"))} </h2>
        <p>
            {React.string(t(`In a two- or three-player game, nicknames for "ghost" players should be added to the list above up to a total of four players.`))}
            {React.string(" ")}
            {React.string(t("Also check the box below."))}
            {React.string(" ")}
            {React.string(t("Please consult the "))}
            <Link
                href={"doc/Salem 1692 - Rules for 2-3 Players.pdf"}
                text={t("rules for 2-3 players.")}
            />
        </p>
        <Spacer />
        <Button
            label={t("With Ghosts")}
            className={"condensed-es condensed-fr icon-left " ++ (gameState.hasGhostPlayers ? "icon-checked" : "icon-unchecked") }
            onClick
        />
    </>
}


