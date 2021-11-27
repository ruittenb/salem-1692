/** ****************************************************************************
 * GearFloatingButton
 */

open Types

@react.component
let make = (
    ~goToPage,
    ~returnPage: page,
): React.element => {

    let (_navigation, setNavigation) = React.useContext(NavigationContext.context)

    let onClick: clickHandler = (_event => {
        setNavigation(_prev => Some(returnPage))
        goToPage(_prev => Setup)
    })

    <div className="floating-button floating-right icon-gear" onClick></div>
}

