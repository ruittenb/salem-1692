/* *****************************************************************************
 * GearFloatingButton
 */

open Types

@react.component
let make = (~returnPage: page): React.element => {
  let (_currentPage, goToPage) = React.useContext(RouterContext.context)
  let (_navigation, setNavigation) = React.useContext(NavigationContext.context)

  let onClick: clickHandler = _event => {
    setNavigation(_prev => Some(returnPage))
    goToPage(_prev => Setup)
  }

  <div className="topbar-button icon-gear" onClick />
}
