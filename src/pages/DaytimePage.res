
/** ****************************************************************************
 * DaytimePage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let (_language, t) = React.useContext(LanguageContext.context)

    let (_, setTurnState) = React.useContext(TurnStateContext.context)
    let defaultNextState = {
        nrWitches: 2,
        hasConstable: false,
        choiceWitches: "",
        choiceConstable: "",
    }

    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("Daytime"))} </h1>
        <Spacer />
        <LargeButton onClick={ _event => {
            setTurnState(_prev => { ...defaultNextState, nrWitches: 1 })
            goToPage(_prev => FirstNightOneWitch)
        } } >
            {React.string(t("First night,"))} <br />
            {React.string(t("one witch"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => FirstNightMoreWitches)
        } } >
            {React.string(t("First night,"))} <br />
            {React.string(t("more witches"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => { ...defaultNextState, hasConstable: true })
            goToPage(_prev => OtherNightWithConstable)
        } } >
            {React.string(t("Other nights,"))} <br />
            {React.string(t("with constable"))}
        </LargeButton>
        <LargeButton onClick={ _event => {
            setTurnState(_prev => defaultNextState)
            goToPage(_prev => OtherNightNoConstable)
        } } >
            {React.string(t("Other nights,"))} <br />
            {React.string(t("without constable"))}
        </LargeButton>
        <Spacer />
        <Button
            label={t("Back")}
            className="icon-left icon-back"
            onClick={ _event => goToPage(_prev => Title) }
        />
    </div>
}


