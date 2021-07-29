
/** ****************************************************************************
 * PlayerEntryList
 */

open Types


@react.component
let make = (): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let onClick: clickHandler = (_event) => {
        setGameState(prevGameState => {
            {
                ...prevGameState,
                players: gameState.players // TODO
            }
        })
    }

    let playerItems = gameState.players->Js.Array2.map(
        (player) => <PlayerEntryItem key=player value=player onClick />
    )

    <>
        <h2> {React.string(t("Names"))} </h2>
        {React.array(playerItems)}
    </>
}

