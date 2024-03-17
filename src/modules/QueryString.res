/* *****************************************************************************
 * QueryString
 */

open Constants

@get external location: Dom.window => Dom.location = "location"
@get external search: Dom.location => string = "search"

let queryString = window->location->search->Js.String.sliceToEnd(~from=1) // remove '?'

let queryParams = queryString->Js.String2.split("&")->Js.Array2.reduce((acc, item) => {
    let pair = item->Js.String2.split("=")
    if pair->Js.Array.length > 1 {
      acc->Js.Dict.set(pair[0], pair[1])
    }
    acc
  }, Js.Dict.empty())

let getQueryParam = (paramName: string) => {
  queryParams->Js.Dict.get(paramName)
}
