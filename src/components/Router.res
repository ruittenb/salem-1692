/* *****************************************************************************
 * Router
 */

open Types

let initialPage: page = Title

@react.component
let make = (): React.element => {
  let (currentPage, goToPage) = React.useState(_ => initialPage)

  <RouterContext.Provider value=(currentPage, goToPage)>
    <RootPage />
  </RouterContext.Provider>
}
