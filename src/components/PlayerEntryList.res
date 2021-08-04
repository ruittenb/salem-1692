
/** ****************************************************************************
 * PlayerEntryList
 */

open Types

/**
 * get the array slice with items 0..index
 */
let sliceFirst = (items, index) => {
    // note that slice() does not include the end_ position
    items->Js.Array2.slice(~start=0, ~end_=index+1)
}

/**
 * get the array slice with items index..$#
 */
let sliceLast = (items, index) => {
    items->Js.Array2.sliceFrom(index)
}

/**
 * concatenate three arrays
 */
let arrayConcat3 = (items1, items2, items3) => {
    items1->Js.Array2.concatMany([ items2, items3 ])
}

@react.component
let make = (): React.element => {

    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    // handlers for existing players
    let blurHandler: (int => blurHandler) = (playerIndex, event) => {
        let newValue: player = ReactEvent.Focus.currentTarget(event)["value"]
        setGameState(prevGameState => {
            let players = arrayConcat3(
                prevGameState.players->sliceFirst(playerIndex - 1),
                [ newValue ],
                prevGameState.players->sliceLast(playerIndex + 1)
            )
            { ...prevGameState, players }
        })
    }
    let removeHandler: (int => clickHandler) = (playerIndex, _event) => {
        setGameState(prevGameState => {
            let players = Js.Array2.concat(
                prevGameState.players->sliceFirst(playerIndex - 1),
                prevGameState.players->sliceLast(playerIndex + 1)
            )
            { ...prevGameState, players }
        })
    }
    let moveHandler: (int => clickHandler) = (playerIndex, _event) => {
        setGameState(prevGameState => {
            let firstSwapPlayer : option<player> = prevGameState.players->Belt.Array.get(playerIndex)
            let secondSwapPlayer: option<player> = prevGameState.players->Belt.Array.get(playerIndex + 1)

            let players = switch (firstSwapPlayer, secondSwapPlayer) {
                | (Some(first), Some(second)) => {
                    arrayConcat3(
                        prevGameState.players->sliceFirst(playerIndex - 1),
                        [ second, first ],
                        prevGameState.players->sliceLast(playerIndex + 2),
                    )
                }
                | (_, _) => prevGameState.players // no change
            }
            { ...prevGameState, players }
        })
    }
    // handler for new players
    let addHandler: blurHandler = (event) => {
        let newPlayer: player = ReactEvent.Focus.currentTarget(event)["value"]
        setGameState(prevGameState => {
            let newPlayers = if newPlayer->Js.String.length > 0 {
                [ newPlayer ]
            } else {
                []
            }
            let players = Js.Array2.concat(prevGameState.players, newPlayers)
            { ...prevGameState, players }
        })
    }

    // create buttons for every player
    let playerItems = gameState.players->Js.Array2.mapi(
        (player, index) => {
            let showMoveButton = index + 1 < gameState.players->Js.Array.length
            <PlayerEntryItem
                key={Belt.Int.toString(index) ++ "/" ++ player} // make key unique
                value=player
                showMoveButton
                showRemoveButton=true
                onMove=moveHandler(index)
                onRemove=removeHandler(index)
                onBlur=blurHandler(index)
            />
        }
    )

    <>
        <h2> {React.string(t("Names"))} </h2>
        <div className="paragraph">
            {React.string(t("Enter the names of the players in clockwise order, starting at the head of the table."))}
        </div>
        {React.array(playerItems)}
        <PlayerEntryItem
            key={gameState.players->Belt.Array.length->Belt.Int.toString} // make key unique
            value=""
            showMoveButton=false
            showRemoveButton=false
            onBlur=addHandler
        />
    </>
}

