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
    card1.power > card2.power


maxPower : Card -> Card -> Int
maxPower card1 card2 =
    max card1.power card2.power


sortByMonsterName : List Card -> List Card
sortByMonsterName =
    List.sortBy .monster


sortByCoolness : List Card -> List Card
sortByCoolness =
    let
        coolness { power, shiny } =
            ( negate (shinyValue shiny), negate power )
    in
    List.sortBy coolness


compareShinyPower : Card -> Card -> Order
compareShinyPower card1 card2 =
    compare ( card1.power, shinyValue card1.shiny ) ( card2.power, shinyValue card2.shiny )


expectedWinner : Card -> Card -> String
expectedWinner card1 card2 =
    case compareShinyPower card1 card2 of
        EQ ->
            "too close to call"

        LT ->
            card2.monster

        GT ->
            card1.monster


shinyValue : Bool -> Int
shinyValue shiny =
    if shiny then
        1

    else
        0
