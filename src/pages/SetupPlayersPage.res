
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (gameState, setGameState) = React.useContext(GameStateContext.context)

    let evenOdd = if gameState.players->Js.Array2.length->mod(2) === 0 { Even } else { Odd }

    let onClick: (seatingLayout => clickHandler) = (seatingLayout, _event) => setGameState(prevGameState => {
        ...prevGameState,
        seatingLayout
    })

    <div id="setup-page" className="page flex-vertical">
        <h1> {React.string(t("Players"))} </h1>
        <Spacer />
        <h2> {React.string(t("Seating layout"))} </h2>
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
                            <SquareButton className="layout-2222 icon-left icon-unchecked" onClick=onClick(TwoAtHead) />
                            <SquareButton className="layout-1221 icon-left icon-checked"   onClick=onClick(OneAtHead) />
                        </>
                    }
                    | (Even, TwoAtHead) => {
                        <>
                            <SquareButton className="layout-2222 icon-left icon-checked"   onClick=onClick(TwoAtHead) />
                            <SquareButton className="layout-1221 icon-left icon-unchecked" onClick=onClick(OneAtHead) />
                        </>
                    }
                }
            }
        </div>
        <Spacer />
        <Button
            label={t("Back")}
            onClick={ _event => goToPage(_prev => Setup) }
            className="icon-left icon-back"
        />
    </div>
}


