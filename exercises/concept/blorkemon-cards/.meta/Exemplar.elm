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
isMorePowerful ( _, power1, _ ) ( _, power2, _ ) =
    power1 > power2


maxPower : Card -> Card -> Power
maxPower ( _, power1, _ ) ( _, power2, _ ) =
    max power1 power2


sortByMonsterName : List Card -> List Card
sortByMonsterName =
    let
        getName ( name, _, _ ) =
            name
    in
    List.sortBy getName


sortByCoolness : List Card -> List Card
sortByCoolness =
    let
        coolness ( _, power, shiny ) =
            ( negate (shinyValue shiny), negate power )
    in
    List.sortBy coolness


compareShinyPower : Card -> Card -> Order
compareShinyPower ( _, power1, shiny1 ) ( _, power2, shiny2 ) =
    compare ( power1, shinyValue shiny1 ) ( power2, shinyValue shiny2 )


expectedWinner : Card -> Card -> Monster
expectedWinner (( monster1, _, _ ) as card1) (( monster2, _, _ ) as card2) =
    case compareShinyPower card1 card2 of
        EQ ->
            "too close to call"

        LT ->
            monster2

        GT ->
            monster1


shinyValue : Shiny -> Int
shinyValue shiny =
    if shiny then
        1

    else
        0
