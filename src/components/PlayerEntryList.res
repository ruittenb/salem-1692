
/** ****************************************************************************
 * PlayerEntryList
 */

open Types


@react.component
let make = (): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let changeHandler: (int => changeHandler) = (playerIndex, event) => {
        let newValue: player = ReactEvent.Form.currentTarget(event)["value"]
        setGameState(prevGameState => {
            let players = prevGameState.players
                    ->Js.Array2.slice(~start=0, ~end_=playerIndex) // end_ position not included
                    ->Js.Array2.concatMany([
                        [ newValue ],
                        prevGameState.players->Js.Array2.sliceFrom(playerIndex + 1),
                    ])
            {
                ...prevGameState,
                players
            }
        })
    }
    let removeHandler: (int => clickHandler) = (playerIndex, _event) => {
        setGameState(prevGameState => {
            let players = prevGameState.players
                ->Js.Array2.slice(~start=0, ~end_=playerIndex) // end_ position not included
                ->Js.Array2.concat(
                    prevGameState.players->Js.Array2.sliceFrom(playerIndex + 1)
                )
            {
                ...prevGameState,
                players
            }
        })
    }
    let moveHandler: (int => clickHandler) = (playerIndex, _event) => { // TODO
        setGameState(prevGameState => {
            Js.log2("moving", playerIndex)
            {
                ...prevGameState,
                players: prevGameState.players // TODO
            }
        })
    }
    let addHandler: changeHandler = (_event) => { // TODO
        setGameState(prevGameState => {
            {
                ...prevGameState,
                players: prevGameState.players // TODO
            }
        })
    }


    let playerItems = gameState.players->Js.Array2.mapi(
        (player, index) =>
            <PlayerEntryItem
                key={Belt.Int.toString(index) ++ "/" ++ player} // make key unique
                value=player
                onChange=changeHandler(index)
                onMove=moveHandler(index)
                onRemove=removeHandler(index)
            />
    )

    <>
        <h2> {React.string(t("Names"))} </h2>
        {React.array(playerItems)}
    </>
}

