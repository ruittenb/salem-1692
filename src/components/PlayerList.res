
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (~state: state): React.element => {
    let buttons = state.currentPlayers
        ->Belt.Array.map((player) => {
            <Button key={player.name} label={player.name} onClick={ (_) => () } /> // TODO onclick
        })
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <>
        {React.string(t("Players"))}
        {React.array(buttons)}
    </>
}

