
/** ****************************************************************************
 * SettingsGear
 */

@@warning("-33") // Unused 'open Types'

open Types

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {

    let onClick: clickHandler = (_event => {
        goToPage(_prev => Setup(returnPage))
    })

    <div className="icon-gear" onClick></div>
}

