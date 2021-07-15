
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (
    ~title: string,
    ~subtitle: string,
    ~players: players,
    ~choiceHandler: (player, _) => unit,
): React.element => {
    let buttons = players
        ->Belt.Array.map(player => {
            <SquareButton key={player} label={player} onClick=choiceHandler(player) />
        })
    //let language = React.useContext(LanguageContext.context)
    //let t = Translator.getTranslator(language)
    <>
        <h2> {React.string(title)} </h2>
        <div> {React.string(subtitle)} </div>
        <div id="player-list">
            {React.array(buttons)}
        </div>
    </>
}

