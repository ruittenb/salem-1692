
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Constants

@react.component
let make = (
    ~goToPage,
    ~fromTitle: bool = false, // was this page reached from the Title page or from Setup?
): React.element => {
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let hasEnoughPlayers = gameState.players->Js.Array.length > 1 // needs at least 2 players

    let backPage = if fromTitle { Title } else { Setup }
    let backButton =
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => backPage) }
            className="icon-left icon-back spacer-top"
        />
    let forwardButton =
        <Button
            label={t("Play")}
            disabled={!hasEnoughPlayers}
            onClick={ _event => goToPage(_prev => Daytime) }
            className="icon-left icon-forw spacer-top condensed-nl"
        />

    <div id="setup-players-page" className="page flex-vertical">
        <h1> {React.string(t("Players"))} </h1>
        <PlayerForm />
        <Spacer />
        <SeatingForm />
        {
            if fromTitle {
                <ButtonPair>
                    {backButton}
                    {forwardButton}
                </ButtonPair>
            } else {
                {backButton}
            }
        }
    </div>
}

