
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (
    ~addressed: addressed,
    ~players: players,
    ~choiceHandler: (player, _) => unit,
): React.element => {

    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    let (title, subtitle) = switch addressed {
        | Witch     => (t("The witch's turn"),     t("Choose-SG a victim:"))
        | Witches   => (t("The witches' turn"),    t("Choose-PL a victim:"))
        | Constable => (t("The constable's turn"), t("Choose someone to protect:"))
    }

    let buttons = players
        ->Belt.Array.map(player => {
            <SquareButton key={player} label={player} onClick=choiceHandler(player) />
        })

    <>
        <h2> {React.string(title)} </h2>
        <div> {React.string(subtitle)} </div>
        <div id="player-list">
            {React.array(buttons)}
        </div>
    </>
}

