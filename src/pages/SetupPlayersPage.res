
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Constants

@react.component
let make = (
    ~goToPage,
    ~contineToGame: bool = false,
): React.element => {
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let hasEnoughPlayers = gameState.players->Js.Array.length > 1 // needs at least 2 players

    <div id="setup-players-page" className="page flex-vertical">
        <h1> {React.string(t("Players"))} </h1>
        <PlayerForm />
        <Spacer />
        <SeatingForm />
        {
            if contineToGame && hasEnoughPlayers {
                <ButtonPair>
                    <Button
                        label={t("Back")}
                        onClick={ _event => goToPage(_prev => Title) }
                        className="icon-left icon-back spacer-top"
                    />
                    <Button
                        label={t("Next")}
                        onClick={ _event => goToPage(_prev => Daytime) }
                        className="condensed_nl icon-left icon-forw spacer-top"
                    />
                </ButtonPair>
            } else {
                let backPage = if contineToGame { Title } else { Setup }
                <Button
                    label={t("Back")}
                    onClick={ _event => goToPage(_prev => backPage) }
                    className="icon-left icon-back spacer-top"
                />
            }
        }
    </div>
}

