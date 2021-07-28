
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (
    ~addressed: addressed,
    ~choiceHandler: (player, _) => unit,
): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (rotated, setRotate) = React.useState(_ => false)
    let rotatedClass = if rotated { "rotated" } else { "" }

    let (title, subtitle) = switch addressed {
        | Witch     => (t("The witch's turn"),     t("Choose-SG a victim:"))
        | Witches   => (t("The witches' turn"),    t("Choose-PL a victim:"))
        | Constable => (t("The constable's turn"), t("Choose someone to protect:"))
    }

    let (gameState, _) = React.useContext(GameStateContext.context)
    let buttons = gameState.players
        ->Belt.Array.map(player => {
            <SquareButton key={player} label={player} className=rotatedClass onClick=choiceHandler(player) />
        })

    let evenOddClass = if gameState.players->Belt.Array.length->mod(2) === 0 { "even" } else { "odd" }
    let headClass    = switch gameState.seatingLayout {
        | OneAtHead => "one-at-head"
        | TwoAtHead => "two-at-head"
    }

    <>
        <h2> {React.string(title)} </h2>
        <div> {React.string(subtitle)} </div>
        <div id="player-list" className={ headClass ++ " " ++ evenOddClass }>
            {React.array(buttons)}
        </div>
        <Spacer />
        <Button
            label={t("Rotate")}
            className="icon-left icon-rot"
            onClick={ (_event) => setRotate(prev => !prev) }
        />
    </>
}

