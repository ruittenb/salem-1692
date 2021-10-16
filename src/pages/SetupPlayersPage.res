
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

    let forwardButton =
        <Button
            label={t("Play")}
            disabled={!hasEnoughPlayers}
            onClick={ _event => goToPage(_prev => Daytime) }
            className="icon-left icon-forw spacer-top condensed-nl"
        />

    let okButton =
        <Button
            label={t("OK")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="spacer-top"
        />

    <div id="setup-players-page" className="page flex-vertical">
        <BackFloatingButton onClick={ _event => goToPage(_prev => returnPage) } />
        <h1> {React.string(t("Players"))} </h1>
        <PlayerForm />
        <Spacer />
        <SeatingForm />
        {
            if returnPage == Title {
                // back == Title, forward == Daytime
                {forwardButton}
            } else {
                // back == Setup, ok == Setup
                {okButton}
            }
        }
    </div>
}

