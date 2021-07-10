
/** ****************************************************************************
 * PlayerList
 */

open Types

@react.component
let make = (~state: state): React.element => {
    let buttons = state.currentPlayers
        ->Belt.Array.map((player) => {
            <Button key={player.name} label={player.name} />
        })
    let locale = React.useContext(LocaleContext.context)
    let t = Translator.getTranslator(locale)
    <div id="player-list" className="flex-vertical">
        {React.string(t("Players"))}
        {React.array(buttons)}
    </div>
}

