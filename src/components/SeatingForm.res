/* *****************************************************************************
 * SeatingForm
 */

open Types

@react.component
let make = (): React.element => {
  let (gameState, setGameState) = React.useContext(GameStateContext.context)
  let t = Translator.getTranslator(gameState.language)

  let evenOdd = if gameState.players->Array.length->mod(2) === 0 {
    Even
  } else {
    Odd
  }

  let onClick: SeatingCodec.t => clickHandler = seating => {
    let newGameState = {
      ...gameState,
      seating,
    }
    _event => setGameState(_prevGameState => newGameState)
  }

  <>
    <h2> {React.string(t("Seating layout"))} </h2>
    <p>
      {React.string(t("How are the players seated around the table?"))}
      {React.string(" ")}
      {React.string(t("This affects the positioning of the player buttons at night."))}
    </p>
    <div id="layout-list">
      {switch (evenOdd, gameState.seating) {
      | (Odd, OneAtTop) =>
        <>
          <BulkyButton className="layout-1222 icon-left icon-checked" onClick={onClick(OneAtTop)} />
          <BulkyButton
            className="layout-2221 icon-left icon-unchecked" onClick={onClick(TwoAtTop)}
          />
        </>
      | (Odd, TwoAtTop) =>
        <>
          <BulkyButton
            className="layout-1222 icon-left icon-unchecked" onClick={onClick(OneAtTop)}
          />
          <BulkyButton className="layout-2221 icon-left icon-checked" onClick={onClick(TwoAtTop)} />
        </>
      | (Even, OneAtTop) =>
        <>
          <BulkyButton className="layout-1221 icon-left icon-checked" onClick={onClick(OneAtTop)} />
          <BulkyButton
            className="layout-2222 icon-left icon-unchecked" onClick={onClick(TwoAtTop)}
          />
        </>
      | (Even, TwoAtTop) =>
        <>
          <BulkyButton
            className="layout-1221 icon-left icon-unchecked" onClick={onClick(OneAtTop)}
          />
          <BulkyButton className="layout-2222 icon-left icon-checked" onClick={onClick(TwoAtTop)} />
        </>
      }}
    </div>
  </>
}
