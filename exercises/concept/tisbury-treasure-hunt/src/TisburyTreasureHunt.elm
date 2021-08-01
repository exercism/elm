module TisburyTreasureHunt exposing (..)

-- Consider defining a type alias for TreasureLocation, 
-- Treasure, Placelocation and Place, 
-- and using them in the function type annotations


placeLocationToTreasureLocation: (Char, Int) -> (Int, Char)
placeLocationToTreasureLocation placeLocation =
    Debug.todo "implement this function"

treasureLocationMatchesPlaceLocation: (Int, Char) -> (Char, Int) -> Bool
treasureLocationMatchesPlaceLocation treasureLocation placeLocation =
    Debug.todo "implement this function"

countTreasureLocations: (String, TreasureLocation) -> List (String, PlaceLocation) -> Int
countTreasureLocations (_, treasureLocation) places =
    Debug.todo "implement this function"

specialCaseSwapPossible: (String, TreasureLocation) -> (String, PlaceLocation) -> (String, TreasureLocation) -> Bool
specialCaseSwapPossible (foundTreasure, _) (place, _) (desiredTreasure, _) =
    Debug.todo "implement this function"
