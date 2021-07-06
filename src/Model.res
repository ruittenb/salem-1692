

type page =
    | Title
    | Players
    | Turn
    | NightWitch
    | NightConstable


type player =
    { name : String
    }


type state =
    { currentPage : page
    , currentPlayers : array<player>
    }


type msg =
    | Nop
    | Exit
