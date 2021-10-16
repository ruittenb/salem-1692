
/** ****************************************************************************
 * SeatingForm
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (): React.element => {
    let (gameState, setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let evenOdd = if gameState.players->Js.Array2.length->mod(2) === 0 { Even } else { Odd }

    let onClick: (SeatingCodec.t => clickHandler) = (seating, _event) => {
        let newGameState = {
            ...gameState,
            seating
        }
        setGameState(_prevGameState => newGameState)
    }

    <>
        <h2> {React.string(t("Seating layout"))} </h2>
        <p>
            {React.string(t("How are the players seated around the table?"))}
        </p>
        <div id="layout-list">
            {
                switch (evenOdd, gameState.seating) {
                    | (Odd, #OneAtTop) => {
                        <>
                            <SquareButton className="layout-1222 icon-left icon-checked"   onClick=onClick(#OneAtTop) />
                            <SquareButton className="layout-2221 icon-left icon-unchecked" onClick=onClick(#TwoAtTop) />
                        </>
                    }
                    | (Odd, #TwoAtTop) => {
                        <>
                            <SquareButton className="layout-1222 icon-left icon-unchecked" onClick=onClick(#OneAtTop) />
                            <SquareButton className="layout-2221 icon-left icon-checked"   onClick=onClick(#TwoAtTop) />
                        </>
                    }
                    | (Even, #OneAtTop) => {
                        <>
                            <SquareButton className="layout-1221 icon-left icon-checked"   onClick=onClick(#OneAtTop) />
                            <SquareButton className="layout-2222 icon-left icon-unchecked" onClick=onClick(#TwoAtTop) />
                        </>
                    }
                    | (Even, #TwoAtTop) => {
                        <>
                            <SquareButton className="layout-1221 icon-left icon-unchecked" onClick=onClick(#OneAtTop) />
                            <SquareButton className="layout-2222 icon-left icon-checked"   onClick=onClick(#TwoAtTop) />
                        </>
                    }
                }
            }
        </div>
    </>
}


