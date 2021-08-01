module TisburyTreasureHunt exposing (..)

-- Consider defining a type alias for TreasureLocation,
-- Treasure, Placelocation and Place,
-- and using them in the function type annotations


placeLocationToTreasureLocation : ( Char, Int ) -> ( Int, Char )
placeLocationToTreasureLocation placeLocation =
    Debug.todo "implement this function"


treasureLocationMatchesPlaceLocation : ( Char, Int ) -> ( Int, Char ) -> Bool
treasureLocationMatchesPlaceLocation placeLocation treasureLocation =
    Debug.todo "implement this function"


countPlaceTreasures : ( String, (Char, Int) ) -> List ( String, (Int, Char) ) -> Int
countPlaceTreasures place treasures =
    Debug.todo "implement this function"


specialCaseSwapPossible : ( String, TreasureLocation ) -> ( String, PlaceLocation ) -> ( String, TreasureLocation ) -> Bool
specialCaseSwapPossible ( foundTreasure, _ ) ( place, _ ) ( desiredTreasure, _ ) =
    Debug.todo "implement this function"
