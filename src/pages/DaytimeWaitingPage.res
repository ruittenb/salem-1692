/** ****************************************************************************
 * DaytimeWaitingPage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (gameState, _) = React.useContext(GameStateContext.context)
    let t = Translator.getTranslator(gameState.language)

    // component
    <>
        <h1> {React.string(t("Daytime"))} </h1>
        <Spacer />
        <p className="text-centered"> {React.string(t("Waiting for the host to announce nighttime..."))} </p>
        <Spacer />
        <Spacer />
        <Button
            label={t("Abort")}
            className="icon-left icon-abort"
            onClick={ _event => goToPage(_prev => SetupNetwork) }
        />
    </>
}

