
/** ****************************************************************************
 * SeatingLayoutList
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)
    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let evenOdd = if gameState.players->Js.Array2.length->mod(2) === 0 { Even } else { Odd }

    let onClick: (seatingLayout => clickHandler) = (seatingLayout, _event) => setGameState(prevGameState => {
        ...prevGameState,
        seatingLayout
    })

    <>
        <h2> {React.string(t("Seating layout"))} </h2>
        <div className="paragraph">
            {React.string(t("How are the players seated around the table?"))}
        </div>
        <div id="layout-list">
            {
                switch (evenOdd, gameState.seatingLayout) {
                    | (Odd, OneAtHead) => {
                        <>
                            <SquareButton className="layout-1222 icon-left icon-checked"   onClick=onClick(OneAtHead) />
                            <SquareButton className="layout-2221 icon-left icon-unchecked" onClick=onClick(TwoAtHead) />
                        </>
                    }
                    | (Odd, TwoAtHead) => {
                        <>
                            <SquareButton className="layout-1222 icon-left icon-unchecked" onClick=onClick(OneAtHead) />
                            <SquareButton className="layout-2221 icon-left icon-checked"   onClick=onClick(TwoAtHead) />
                        </>
                    }
                    | (Even, OneAtHead) => {
                        <>
                            <SquareButton className="layout-1221 icon-left icon-checked"   onClick=onClick(OneAtHead) />
                            <SquareButton className="layout-2222 icon-left icon-unchecked" onClick=onClick(TwoAtHead) />
                        </>
                    }
                    | (Even, TwoAtHead) => {
                        <>
                            <SquareButton className="layout-1221 icon-left icon-unchecked" onClick=onClick(OneAtHead) />
                            <SquareButton className="layout-2222 icon-left icon-checked"   onClick=onClick(TwoAtHead) />
                        </>
                    }
                }
            }
        </div>
    </>
}


