module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : Card -> Card -> Bool
isMorePowerful card1 card2 =
    Debug.todo "Please implement this function"


maxPower : Card -> Card -> Int
maxPower card1 card2 =
    Debug.todo "Please implement this function"


sortByMonsterName : List Card -> List Card
sortByMonsterName cards =
    Debug.todo "Please implement this function"


sortByCoolness : List Card -> List Card
sortByCoolness cards =
    Debug.todo "Please implement this function"


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    Debug.todo "Please implement this function"


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    Debug.todo "Please implement this function"
