/* *****************************************************************************
 * PlayerForm
 */

open Types

/**
 * get the array slice with items 0..index
 */
let sliceFirst = (items, index) => {
  // note that slice() does not include the end_ position
  items->Array.slice(~start=0, ~end=index + 1)
}

/**
 * get the array slice with items index..$#
 */
let sliceLast = (items, index) => {
  items->Array.sliceToEnd(~start=index)
}

/**
 * concatenate three arrays
 */
let arrayConcat3 = (items1, items2, items3) => {
  items1->Array.concatMany([items2, items3])
}

/**
 * "respace" a string: if it doesn't end in a space, add one; else remove it
 */
let respace = (str: string): string => {
  let finalSpace = Js.Re.fromString(" $")
  if finalSpace->Js.Re.test_(str) {
    str->String.replaceRegExp(finalSpace, "")
  } else {
    str ++ " "
  }
}

@react.component
let make = (): React.element => {
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  // change a player on leaving the field
  let blurHandler: int => blurHandler = playerIndex => {
    event => {
      let newValue: string = ReactEvent.Focus.target(event)["value"]
      let oldValue: string = ReactEvent.Focus.target(event)["defaultValue"]
      let isNewValueEmpty = newValue->String.length === 0
      let isLastPlayer = gameState.players->Array.length < 2
      let newPlayer = switch (isNewValueEmpty, isLastPlayer) {
      | (false, _) => [PlayerCodec.Player(newValue)] // accept the new name if it is not empty
      | (true, false) => [] // delete the name if it is empty
      | (true, true) => [PlayerCodec.Player(respace(oldValue))] // refuse to delete name if it is the last one
      }
      let players: array<PlayerCodec.t> = arrayConcat3(
        gameState.players->sliceFirst(playerIndex - 1),
        newPlayer,
        gameState.players->sliceLast(playerIndex + 1),
      )
      setGameState(prevGameState => {
        ...prevGameState,
        players,
      })
    }
  }
  // remove a player on button click
  let removeHandler: int => clickHandler = playerIndex => {
    _event => {
      let players: array<PlayerCodec.t> = Array.concat(
        gameState.players->sliceFirst(playerIndex - 1),
        gameState.players->sliceLast(playerIndex + 1),
      )
      setGameState(prevGameState => {
        ...prevGameState,
        players,
      })
    }
  }
  // swap two players
  let swapHandler: int => clickHandler = playerIndex => {
    _event => {
      let firstSwapPlayer: option<PlayerCodec.t> = gameState.players->Array.get(playerIndex)
      let secondSwapPlayer: option<PlayerCodec.t> = gameState.players->Array.get(playerIndex + 1)

      let players: array<PlayerCodec.t> = switch (firstSwapPlayer, secondSwapPlayer) {
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
  }
  // add a new player
  let addHandler: blurHandler = event => {
    let newPlayer: string = ReactEvent.Focus.target(event)["value"]
    let newPlayers = if newPlayer->Js.String.length > 0 {
      [PlayerCodec.Player(newPlayer)]
    } else {
      []
    }
    let players = Array.concat(gameState.players, newPlayers)
    setGameState(prevGameState => {
      ...prevGameState,
      players,
    })
  }

  // create buttons for every player
  let numPlayers = gameState.players->Array.length
  let playerFormItems = gameState.players->Array.mapWithIndex((player, index) => {
    // hide the swap button on the last player
    let showSwapButton = numPlayers > index + 1
    // hide the remove button if there is only one player
    let showRemoveButton = numPlayers > 1
    switch player {
    | Player(playerName) =>
      <PlayerFormLine
        key={Int.toString(index) ++ "/" ++ playerName} // make key unique
        value=playerName
        showSwapButton
        showRemoveButton
        onSwap={swapHandler(index)}
        onRemove={removeHandler(index)}
        onBlur={blurHandler(index)}
      />
    | _ => React.null
    }
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
    {React.array(playerFormItems)}
    <PlayerFormLine
      key={gameState.players->Array.length->Int.toString} // make key unique
      value=""
      className="condensed-fr condensed-uk"
      placeholder={t("(add one)")}
      showSwapButton=false
      showRemoveButton=false
      onBlur=addHandler
    />
  </>
}
