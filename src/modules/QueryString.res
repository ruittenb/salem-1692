/* *****************************************************************************
 * QueryString
 */

@get external location: Dom.window => Dom.location = "location"
@get external search: Dom.location => string = "search"

let queryString = window->location->search->Js.String.sliceToEnd(~from=1) // remove '?'

let queryParams =
  queryString
  ->String.split("&")
  ->Array.reduce(Js.Dict.empty(), (acc, item) => {
    let pair = item->String.split("=")
    switch (pair[0], pair[1]) {
    | (Some(key), Some(value)) => acc->Js.Dict.set(key, value)
    | (_, _) => ()
    }
    acc
  })

let getQueryParam = (paramName: string) => {
  queryParams->Js.Dict.get(paramName)
}
