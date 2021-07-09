
/** ****************************************************************************
 * TitlePage
 */

@react.component
let make = (
    ~t: string => string
): React.element => {
    <div id="title-page" className="page">
        <Button label={t("New Game")} />
        <Button label={t("Setup"   )} />
        <Button label={t("Exit"    )} className="last" />
    </div>
}

