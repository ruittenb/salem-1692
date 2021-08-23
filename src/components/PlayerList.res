
/** ****************************************************************************
 * PlayerList
 */

open Types

/**
 * apply a function to consecutive elements from two arrays
 * to form a new array with the results:
 *
 * @param  [ a1, a2, a3 ]
 * @param  [ b1, b2, b3 ]
 * @param   a => b => c
 * @return [ c1, c2, c3 ]
 */
let assemble = (
    leftElements: array<'a>,
    rightElements: array<'b>,
    assemblyFn: ('a, 'b) => 'c,
    defaultRight: 'b,
): array<'c> => {
    leftElements->Js.Array2.reducei(
        (acc: array<'c>, leftElement: 'a, index: int) => {
            let maybeRightElement = rightElements
                ->Belt.Array.get(index)
            let rightElement = Js.Option.getWithDefault(defaultRight, maybeRightElement)
            Belt.Array.concat(
                acc,
                [ assemblyFn(leftElement, rightElement) ]
            )
        },
        []
    )
}

/**
 *             even nr. players                       odd nr. players
 *       -----------------------------           --------------------------
 *       TwoAtTop           OneAtTop           OneAtTop        TwoAtTop
 *       ---------           ---------           ---------        ---------
 *         0   1                 1                   1              0   1
 *         2   3               2   3               2   3            2   3
 *         4   5               4   5               4   5            4   5
 *         6   7               6   7               6   7              6
 *                               8
 *
 *    1,3,5,7,6,4,2,0     1,3,5,7,8,6,4,2     1,3,5,7,6,4,2     6,4,2,0,1,3,5
 */
let getSortIndexes = (
    seating: SeatingCodec.t,
    numPlayers: int,
    evenOdd: evenOdd,
): array<int> => {

    switch (evenOdd, seating) {
        | (Even, #TwoAtTop) => Belt.Array.concat(
            Belt.Array.rangeBy(1, numPlayers,   ~step=2),
            Belt.Array.rangeBy(0, numPlayers-1, ~step=2)->Belt.Array.reverse,
        )
        | (Even, #OneAtTop) => Belt.Array.concat(
            Belt.Array.rangeBy(1, numPlayers, ~step=2),
            Belt.Array.rangeBy(2, numPlayers, ~step=2)->Belt.Array.reverse,
        )
        | (Odd, #OneAtTop) => Belt.Array.concat(
            Belt.Array.rangeBy(1, numPlayers, ~step=2),
            Belt.Array.rangeBy(2, numPlayers, ~step=2)->Belt.Array.reverse,
        )
        | (Odd, #TwoAtTop) => Belt.Array.concat(
            Belt.Array.rangeBy(0, numPlayers,   ~step=2)->Belt.Array.reverse,
            Belt.Array.rangeBy(1, numPlayers-1, ~step=2),
        )
    }
}

@react.component
let make = (
    ~addressed: addressed,
    ~choiceHandler: (player, _) => unit,
): React.element => {

    let (gameState, _setGameState) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    let (rotated, setRotate) = React.useState(_ => false)
    let rotatedClass = if rotated { "rotated" } else { "" }

    let (title, subtitle) = switch addressed {
        | Witch     => (t("The witch's turn"),     t("Choose-SG a victim:"))
        | Witches   => (t("The witches' turn"),    t("Choose-PL a victim:"))
        | Constable => (t("The constable's turn"), t("Choose someone to protect:"))
    }

    // determine order in which players must be traversed
    let numPlayers = gameState.players->Belt.Array.length
    let evenOdd = if mod(numPlayers, 2) === 0 { Even } else { Odd }

    let sortIndexes = getSortIndexes(gameState.seating, numPlayers, evenOdd)
    let headPositions = switch (evenOdd, gameState.seating) {
        | (Even, #TwoAtTop) => Belt.Set.Int.fromArray([])
        | (Even, #OneAtTop) => Belt.Set.Int.fromArray([ 1, numPlayers ])
        | (Odd,  #OneAtTop) => Belt.Set.Int.fromArray([ 1 ])
        | (Odd,  #TwoAtTop) => Belt.Set.Int.fromArray([ numPlayers - 1 ])
    }

    let buttons = assemble(
        gameState.players,
        sortIndexes,
        (player, index) => {
            let wideClass = if headPositions->Belt.Set.Int.has(index) { " grid-wide" } else { "" }
            <SquareButton
                key={Belt.Int.toString(index) ++ "/" ++ player} // make key unique
                label=player
                className={rotatedClass ++ wideClass}
                style=ReactDOM.Style.make(~order=Belt.Int.toString(index), ())
                onClick=choiceHandler(player)
            />
        },
        0 // default sort order
    )

    <>
        <h2> {React.string(title)} </h2>
        <div> {React.string(subtitle)} </div>
        <div id="player-list">
            {React.array(buttons)}
        </div>
        <Spacer />
        <Button
            label={t("Rotate")}
            className="icon-left icon-rot spacer-top"
            onClick={ (_event) => setRotate(prev => !prev) }
        />
    </>
}

