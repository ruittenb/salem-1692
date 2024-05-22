/* *****************************************************************************
 * QueryString
 */

@get external location: Dom.window => Dom.location = "location"
@get external search: Dom.location => string = "search"

let queryString = window->location->search->String.sliceToEnd(~start=1) // remove '?'

let queryParams =
  queryString
  ->String.split("&")
  ->Array.reduce(Dict.make(), (acc, item) => {
    let pair = item->String.split("=")
    switch (pair[0], pair[1]) {
    | (Some(key), Some(value)) => acc->Dict.set(key, value)
    | (_, _) => ()
    }
    acc
  })

let getQueryParam = (paramName: string) => {
  queryParams->Dict.get(paramName)
}
