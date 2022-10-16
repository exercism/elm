module BlorkemonCards exposing
    ( compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )


type alias Shiny =
    Bool


type alias Monster =
    String


type alias Power =
    Int


type alias Card =
    ( Monster, Power, Shiny )


isMorePowerful : Card -> Card -> Bool
isMorePowerful card1 card2 =
    Debug.todo "Please implement this function"


maxPower : Card -> Card -> Power
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


expectedWinner : Card -> Card -> Monster
expectedWinner card1 card2 =
    Debug.todo "Please implement this function"
