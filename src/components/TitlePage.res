
/** ****************************************************************************
 * TitlePage
 */

@react.component
let make = (): React.element => {
    <div id="title-page">
        <Button buttonType=RegularFirst  label="New Game" />
        <Button buttonType=RegularSecond label="Setup"    />
        <Button buttonType=RegularThird  label="Exit"     />
    </div>
}

// vim: set ts=4 sw=4 et list nu fdm=marker:

