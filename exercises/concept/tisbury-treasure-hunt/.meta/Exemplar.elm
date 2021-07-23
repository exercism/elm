module TisburyTreasureHunt exposing (penceToPounds, poundsToString)

-- This problem is contrived to demonstrate the use of Tuples, 
-- normally in Elm you would create record types, instead of 
-- tuples for a problem like this

type alias TreasureLocation = String

type alias Treasure = (String, TreasureLocation)

type alias PlaceLocation = (String, String)

type alias Place = (String, PlaceLocation)

-- This uses pattern matching on the function arguments
placeCoordinateToTreasureCoordinate: Treasure -> String
placeCoordinateToTreasureCoordinate (x, y) =
    x ++ y

-- This uses pattern matching on the function arguments, 
-- and a discard argument
treasureCoordinateMatchesPlace: String -> Place -> Bool
treasureCoordinateMatchesPlace treasureCoordinate (_, placeCoordinate)
    treasureCoordinate == placeCoordinateToTreasureCoordinate placeCoordinate

-- This uses pattern matching on the function arguments, 
-- and demonstrates the usefulness of Tuple.first / Tuple.second
countTreasureLocations: Treasure -> List Place -> List String
countTreasureLocations (_, treasureCoordinate) places =
    List.map Tuple.second places
    |> List.filter (treasureCoordinateMatchesPlace treasureCoordinate)
    |> List.length

-- special case swap
-- If you have the Amethyst Octopus at Stormy Breakwater you can swap it for the Crystal Crab, Glass Starfish
-- If you have the Vintage Pirate Hat in the Harbor Managers Office you can swap it for Model Ship in Large Bottle, Antique Glass Fishnet Float
-- If you have the Brass Spyglass in the Abandoned Lighthouse you can swap it for any other treasure
-- This uses the transient use of a tuple in a case statement, which
-- is idiomatic in Elm
specialCaseSwapPossible Treasure -> Place -> Treasure -> Bool
specialCaseSwapPossible (foundTreasure, _) (place, _) (desiredTreasure, _) =
    case (foundTreasure, place, desiredTreasure) of
        ("Amethyst Octopus", "Stormy Breakwater", "Crystal Crab") ->
            True
        ("Amethyst Octopus", "Stormy Breakwater", "Glass Starfish") ->
            True
        ("Vintage Pirate Hat", "Harbor Managers Office", "Model Ship in Large Bottle") ->
            True
        ("Vintage Pirate Hat", "Harbor Managers Office", "Antique Glass Fishnet Float") ->
            True
        ("Brass Spyglass", "Abandoned Lighthouse", _) ->
            True
        _ =>
            False

