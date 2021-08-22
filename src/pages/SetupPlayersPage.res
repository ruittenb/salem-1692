
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types
open Constants

let savePlayersToLocalStorage = (players: array<player>): unit => {
    let storageKey = localStoragePrefix ++ localStoragePlayersKey
    switch Js.Json.stringifyAny(players) {
        | Some(jsonString) => LocalStorage.setItem(storageKey, jsonString)
        | None             => ()
    }
}

@react.component
let make = (
    ~goToPage,
    ~contineToGame: bool = false,
): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, _) = React.useContext(GameStateContext.context)
    let hasEnoughPlayers = gameState.players->Js.Array.length > 1 // need > 2 players

    // cleanup after render
    React.useEffect(() => {
        Some(() => savePlayersToLocalStorage(gameState.players))
    })

    <div id="setup-players-page" className="page flex-vertical">
        <h1> {React.string(t("Players"))} </h1>
        <PlayerEntryList />
        <Spacer />
        <SeatingList />
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
                <Button
                    label={t("Back")}
                    onClick={ _event => goToPage(_prev => Setup) }
                    className="icon-left icon-back spacer-top"
                />
            }
        }
    </div>
}


