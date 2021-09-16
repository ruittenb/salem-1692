
/** ****************************************************************************
 * SetupPlayersPage
 */

open Types

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)
    let hasEnoughPlayers = gameState.players->Js.Array.length >= 2 // needs at least 2 players

    let backButton =
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => returnPage) }
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
            if returnPage == Title {
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

