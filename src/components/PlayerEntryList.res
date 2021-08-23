
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

    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let setAndSaveGameState = (newGameState: gameState): unit => {
        setGameState(_prevState => newGameState)
        LocalStorage.saveGameState(newGameState)
    }

    // handlers for existing players
    let blurHandler: (int => blurHandler) = (playerIndex, event) => {
        let newValue: player = ReactEvent.Focus.currentTarget(event)["value"]
        let players = arrayConcat3(
            gameState.players->sliceFirst(playerIndex - 1),
            [ newValue ],
            gameState.players->sliceLast(playerIndex + 1)
        )
        setAndSaveGameState({ ...gameState, players })
    }
    let removeHandler: (int => clickHandler) = (playerIndex, _event) => {
        let players = Js.Array2.concat(
            gameState.players->sliceFirst(playerIndex - 1),
            gameState.players->sliceLast(playerIndex + 1)
        )
        setAndSaveGameState({ ...gameState, players })
    }
    let moveHandler: (int => clickHandler) = (playerIndex, _event) => {
        let firstSwapPlayer : option<player> = gameState.players->Belt.Array.get(playerIndex)
        let secondSwapPlayer: option<player> = gameState.players->Belt.Array.get(playerIndex + 1)

        let players = switch (firstSwapPlayer, secondSwapPlayer) {
            | (Some(first), Some(second)) => {
                arrayConcat3(
                    gameState.players->sliceFirst(playerIndex - 1),
                    [ second, first ],
                    gameState.players->sliceLast(playerIndex + 2),
                )
            }
            | (_, _) => gameState.players // no change
        }
        setAndSaveGameState({ ...gameState, players })
    }
    // handler for new players
    let addHandler: blurHandler = (event) => {
        let newPlayer: player = ReactEvent.Focus.currentTarget(event)["value"]
        let newPlayers = if newPlayer->Js.String.length > 0 {
            [ newPlayer ]
        } else {
            []
        }
        let players = Js.Array2.concat(gameState.players, newPlayers)
        setAndSaveGameState({ ...gameState, players })
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
            placeholder={t("(add one)")}
            showMoveButton=false
            showRemoveButton=false
            onBlur=addHandler
        />
    </>
}

