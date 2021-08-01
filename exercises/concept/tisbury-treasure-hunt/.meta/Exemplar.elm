module TisburyTreasureHunt exposing (..)

-- This problem is contrived to demonstrate the use of Tuples,
-- normally in Elm you would create record types, instead of
-- tuples for a problem like this


type alias TreasureLocation =
    ( Int, Char )


type alias Treasure =
    ( String, TreasureLocation )


type alias PlaceLocation =
    ( Char, Int )


type alias Place =
    ( String, PlaceLocation )



-- This uses pattern matching on the function arguments
-- and the creation of a tuple


placeLocationToTreasureLocation : PlaceLocation -> TreasureLocation
placeLocationToTreasureLocation ( x, y ) =
    ( y, x )



-- This uses pattern matching on the function arguments,
-- and a discard argument


treasureLocationMatchesPlaceLocation : PlaceLocation -> TreasureLocation -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    treasureLocation == placeLocationToTreasureLocation placeLocation



-- This uses pattern matching on the function arguments,
-- and demonstrates the usefulness of Tuple.first / Tuple.second


countPlaceTreasures : Place -> List Treasure -> Int
countPlaceTreasures ( _, placeLocation ) treasures =
    List.map Tuple.second treasures
        |> List.filter (treasureLocationMatchesPlaceLocation placeLocation)
        |> List.length



-- special case swap
-- If you have the Amethyst Octopus at Stormy Breakwater you can swap it for the Crystal Crab, Glass Starfish
-- If you have the Vintage Pirate Hat in the Harbor Managers Office you can swap it for Model Ship in Large Bottle, Antique Glass Fishnet Float
-- If you have the Brass Spyglass in the Abandoned Lighthouse you can swap it for any other treasure
-- This uses the transient use of a tuple in a case statement, which
-- is idiomatic in Elm


specialCaseSwapPossible : Treasure -> Place -> Treasure -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    case ( foundTreasure, place, desiredTreasure ) of
        ( "Amethyst Octopus", "Stormy Breakwater", "Crystal Crab" ) ->
            True

        ( "Amethyst Octopus", "Stormy Breakwater", "Glass Starfish" ) ->
            True

        ( "Vintage Pirate Hat", "Harbor Managers Office", "Model Ship in Large Bottle" ) ->
            True

        ( "Vintage Pirate Hat", "Harbor Managers Office", "Antique Glass Fishnet Float" ) ->
            True

        ( "Brass Spyglass", "Abandoned Lighthouse", _ ) ->
            True

        _ ->
            False
