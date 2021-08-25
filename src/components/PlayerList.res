
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (
    ~title: string,
    ~players: players
): React.element => {
    let onClick: clickHandler = _ => () // TODO
    let buttons = players
        ->Belt.Array.map(player => {
            <SquareButton key={player} label={player} onClick />
        })
    //let language = React.useContext(LanguageContext.context)
    //let t = Translator.getTranslator(language)
    <>
        <h2> {React.string(title)} </h2>
        <div id="player-list">
            {React.array(buttons)}
        </div>
    </>
}

