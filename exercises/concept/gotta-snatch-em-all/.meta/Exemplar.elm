module GottaSnatchEmAll exposing (..)

import Set exposing (Set)


type alias Card =
    String


newCollection : Card -> Set Card
newCollection =
    Set.singleton


addCard : Card -> Set Card -> ( Bool, Set Card )
addCard card collection =
    ( Set.member card collection, Set.insert card collection )


tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard yourCard theirCard collection =
    ( Set.member yourCard collection && not (Set.member theirCard collection)
    , collection |> Set.remove yourCard |> Set.insert theirCard
    )


removeDuplicates : List Card -> List Card
removeDuplicates =
    Set.fromList >> Set.toList


extraCards : Set Card -> Set Card -> Int
extraCards yourCollection theirCollection =
    Set.diff yourCollection theirCollection
        |> Set.size


boringCards : List (Set Card) -> List Card
boringCards collections =
    case collections of
        [] ->
            []

        collection :: rest ->
            List.foldl Set.intersect collection rest
                |> Set.toList


totalCards : List (Set Card) -> Int
totalCards =
    List.foldl Set.union Set.empty
        >> Set.size


splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards collection =
    let
        ( shiny, notShiny ) =
            Set.partition (String.startsWith "Shiny") collection
    in
    ( Set.toList shiny, Set.toList notShiny )
