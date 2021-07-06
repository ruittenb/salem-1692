module Model exposing (..)


type Page
    = Title
    | Players
    | Turn
    | NightWitch
    | NightConstable


type alias Player =
    { name : String
    }


type alias Model =
    { currentPage : Page
    , currentPlayers : List Player
    }


type Msg
    = Nop
    | Exit
