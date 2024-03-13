/* *****************************************************************************
 * SeatingCodec
 */

/**
 * How are the players seated around the table?
 *
 *           even nr. players          odd nr. players
 *        ----------------------    ----------------------
 *        TwoAtTop      OneAtTop    OneAtTop      TwoAtTop
 *        --------      --------    --------      --------
 *          o   o          o            o          o   o
 *          o   o        o   o        o   o        o   o
 *          o   o        o   o        o   o        o   o
 *          o   o          o          o   o          o
 */

// generates the functions seatingToJs() and seatingFromJs()
@deriving(jsConverter)
type seating = [
  | #OneAtTop
  | #TwoAtTop
]

let encoder: Decco.encoder<seating> = (seating: seating): Js.Json.t => {
  seating->seatingToJs->Decco.stringToJson
}

let decoder: Decco.decoder<seating> = (json: Js.Json.t): Belt.Result.t<
  seating,
  Decco.decodeError,
> => {
  switch json->Decco.stringFromJson {
  | Belt.Result.Ok(v) =>
    switch v->seatingFromJs {
    | None => Decco.error(~path="", "Invalid enum " ++ v, json)
    | Some(v) => v->Ok
    }
  | Belt.Result.Error(_) as err => err
  }
}

let codec: Decco.codec<seating> = (encoder, decoder)

@decco type t = @decco.codec(codec) seating
