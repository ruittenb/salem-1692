
/** ****************************************************************************
 * DayTimePage
 */

open Types

@react.component
let make = (
    ~goToPage,
): React.element => {
    let language = React.useContext(LanguageContext.context)
    let t = Translator.getTranslator(language)
    <div id="daytime-page" className="page flex-vertical">
        <h1> {React.string(t("Daytime"))} </h1>
        <Spacer />
        <LargeButton onClick={ _event => goToPage(_prev => FirstNight) } >
            {React.string(t("First night"))}
        </LargeButton>
        <LargeButton onClick={ _event => goToPage(_prev => OtherNightWithConstable) } >
            {React.string(t("Other nights, with constable"))}
        </LargeButton>
        <LargeButton onClick={ _event => goToPage(_prev => OtherNightNoConstable) } >
            {React.string(t("Other nights, without constable"))}
        </LargeButton>
        <Spacer />
        <Button
            label={t("Back")}
            className="icon icon_back"
            onClick={ _event => goToPage(_prev => Title) }
        />
    </div>
}


