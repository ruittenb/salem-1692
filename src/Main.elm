module Main exposing (main)

import Browser
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class, href)
import Model exposing (..)


init : String -> ( Model, Cmd Msg )
init flags =
    ( { currentPage = Title
      , currentPlayers = []
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    case model.currentPage of
        Title ->
            div [] [ text "Title Page" ]

        _ ->
            div [] [ text "Other Page" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program String Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
