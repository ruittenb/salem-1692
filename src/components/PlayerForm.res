/* *****************************************************************************
 * PlayerForm
 */

open Types

/**
 * get the array slice with items 0..index
 */
let sliceFirst = (items, index) => {
  // note that slice() does not include the end_ position
  items->Js.Array2.slice(~start=0, ~end_=index + 1)
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
  items1->Js.Array2.concatMany([items2, items3])
}

/**
 * "respace" a string: if it doesn't end in a space, add one; else remove it
 */
let respace = (str: string): string => {
  let finalSpace = Js.Re.fromString(" $")
  if finalSpace->Js.Re.test_(str) {
    str->Js.String2.replaceByRe(finalSpace, "")
  } else {
    str ++ " "
  }
}

@react.component
let make = (): React.element => {
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  // change a player on leaving the field
  let blurHandler: int => blurHandler = (playerIndex, event) => {
    let newValue: player = ReactEvent.Focus.target(event)["value"]
    let oldValue: player = ReactEvent.Focus.target(event)["defaultValue"]
    let isNewValueEmpty = newValue->Js.String2.length === 0
    let isLastPlayer = gameState.players->Js.Array2.length < 2
    let newPlayer = switch (isNewValueEmpty, isLastPlayer) {
    | (false, _) => [newValue] // accept the new name if it is not empty
    | (true, false) => [] // delete the name if it is empty
    | (true, true) => [respace(oldValue)] // refuse to delete name if it is the last one
    }
    let players = arrayConcat3(
      gameState.players->sliceFirst(playerIndex - 1),
      newPlayer,
      gameState.players->sliceLast(playerIndex + 1),
    )
    setGameState(prevGameState => {
      ...prevGameState,
      players,
    })
  }
  // remove a player on button click
  let removeHandler: int => clickHandler = (playerIndex, _event) => {
    let players = Js.Array2.concat(
      gameState.players->sliceFirst(playerIndex - 1),
      gameState.players->sliceLast(playerIndex + 1),
    )
    setGameState(prevGameState => {
      ...prevGameState,
      players,
    })
  }
  // swap two players
  let swapHandler: int => clickHandler = (playerIndex, _event) => {
    let firstSwapPlayer: option<player> = gameState.players->Belt.Array.get(playerIndex)
    let secondSwapPlayer: option<player> = gameState.players->Belt.Array.get(playerIndex + 1)

    let players = switch (firstSwapPlayer, secondSwapPlayer) {
    | (Some(first), Some(second)) =>
      arrayConcat3(
        gameState.players->sliceFirst(playerIndex - 1),
        [second, first],
        gameState.players->sliceLast(playerIndex + 2),
      )
    | (_, _) => gameState.players // no change
    }
    setGameState(prevGameState => {
      ...prevGameState,
      players,
    })
  }
  // add a new player
  let addHandler: blurHandler = event => {
    let newPlayer: player = ReactEvent.Focus.target(event)["value"]
    let newPlayers = if newPlayer->Js.String.length > 0 {
      [newPlayer]
    } else {
      []
    }
    let players = Js.Array2.concat(gameState.players, newPlayers)
    setGameState(prevGameState => {
      ...prevGameState,
      players,
    })
  }

  // create buttons for every player
  let numPlayers = gameState.players->Js.Array.length
  let playerItems = gameState.players->Js.Array2.mapi((player, index) => {
    // hide the swap button on the last player
    let showSwapButton = numPlayers > index + 1
    // hide the remove button if there is only one player
    let showRemoveButton = numPlayers > 1
    <PlayerFormLine
      key={Belt.Int.toString(index) ++ "/" ++ player} // make key unique
      value=player
      showSwapButton
      showRemoveButton
      onSwap={swapHandler(index)}
      onRemove={removeHandler(index)}
      onBlur={blurHandler(index)}
    />
  })

  // component
  <>
    <h2> {React.string(t("Names"))} </h2>
    <p>
      {React.string(
        t("Enter the names of the players in clockwise order, starting at the head of the table."),
      )}
      {React.string(" ")}
      {React.string(t("During the night, player buttons will be shown in this order."))}
    </p>
    {React.array(playerItems)}
    <PlayerFormLine
      key={gameState.players->Belt.Array.length->Belt.Int.toString} // make key unique
      value=""
      className="condensed-fr"
      placeholder={t("(add one)")}
      showSwapButton=false
      showRemoveButton=false
      onBlur=addHandler
    />
  </>
}
