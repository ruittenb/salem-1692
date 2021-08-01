
/** ****************************************************************************
 * SetupPlayersPage
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~goToPage,
    ~contineToGame: bool = false,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)

    <div id="setup-players-page" className="page flex-vertical">
        <h1> {React.string(t("Players"))} </h1>
        <PlayerEntryList />
        <Spacer />
        <SeatingLayoutList />
        {
            if contineToGame {
                <ButtonPair>
                    <Button
                        label={t("Back")}
                        onClick={ _event => goToPage(_prev => Title) }
                        className="icon-left icon-back spacer-top"
                    />
                    <Button
                        label={t("Next")}
                        onClick={ _event => goToPage(_prev => Daytime) }
                        className="icon-left icon-forw spacer-top"
                    />
                </ButtonPair>
            } else {
                <Button
                    label={t("Back")}
                    onClick={ _event => goToPage(_prev => Setup) }
                    className="icon-left icon-back spacer-top"
                />
            }
        }
    </div>
}


