
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (~state: state): React.element => {
    let onClick: (ReactEvent.Mouse.t => unit) = _ => () // TODO
    let buttons = state.currentPlayers
        ->Belt.Array.map((player) => {
            <Button key={player.name} label={player.name} onClick />
        })
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <>
        {React.string(t("Players"))}
        {React.array(buttons)}
    </>
}

