
/** ****************************************************************************
 * TitlePage
 */

let make = (~name): React.element =>
    <div id="title-page">
        {React.string("Hello " ++ name ++ "!")}
    </div>;

// vim: set ts=4 sw=4 et list nu fdm=marker:

