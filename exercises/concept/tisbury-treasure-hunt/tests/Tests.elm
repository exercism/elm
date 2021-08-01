module Tests exposing (tests)

import TisburyTreasureHunt exposing (..)
import Expect exposing (FloatingPointTolerance(..))
import Test exposing (..)


tests : Test
tests =
    describe "TisburyTreasureHunt"
        [ test "placeLocationToTreasureLocation should convert PlaceLocation to TreasureLocation" <|
            \_ ->
                placeLocationToTreasureLocation ('C', 1) 
                    |> Expect.equal (1, 'C')
        , test "1,F is not at Seaside Cottages" <|
            \_ ->
                treasureLocationMatchesPlaceLocation (1, 'F') ('C', 1)
                    |> Expect.equal False
        , test "1, F is at Aqua Lagoon" <|
            \_ ->
                treasureLocationMatchesPlaceLocation (1, 'F') ('F', 1)
                    |> Expect.equal True
        , test "treasure should be matched with locations where they exist" <|
            \_ ->
                 countTreasureLocations 
                    ("Amethyst Octopus", (1, 'F'))
                    [ ("Aqua Lagoon (Island of Mystery)", ('F', 1))
                    , ("Foggy Seacave", ('C', 8))
                    ]
                |> Expect.equal 1
        , test "can swap Amethyst Octopus for Crystal Crab at Stormy Breakwater" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Amethyst Octopus", (1, 'F'))
                    ("Stormy Breakwater", ('B', 5))
                    ("Crystal Crab", (6, 'A'))
                |> Expect.equal True
        , test "can swap Amethyst Octopus for Glass Starfish at Stormy Breakwater" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Amethyst Octopus", (1, 'F'))
                    ("Stormy Breakwater", ('B', 5))
                    ("Glass Starfish", (6, 'D'))
                |> Expect.equal True
        , test "cannot swap Amethyst Octopus for Angry Monkey Figurine at Stormy Breakwater" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Amethyst Octopus", (1, 'F'))
                    ("Stormy Breakwater", ('B', 5))
                    ("Angry Monkey Figurine", (5, 'B'))
                |> Expect.equal False
        , test "can swap Vintage Pirate Hat for Model Ship in Large Bottle at Harbor Managers Office" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Vintage Pirate Hat", (7, 'E'))
                    ("Harbor Managers Office", ('A', 8))
                    ("Model Ship in Large Bottle", (8, 'A'))
                |> Expect.equal True
        , test "can swap Vintage Pirate Hat for Antique Glass Fishnet Float at Harbor Managers Office" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Vintage Pirate Hat", (7, 'E'))
                    ("Harbor Managers Office", ('A', 8))
                    ("Antique Glass Fishnet Float", (3, 'D'))
                |> Expect.equal True
        , test "cannot swap Vintage Pirate Hat for Carved Wooden Elephant at Harbor Managers Office" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Vintage Pirate Hat", (7, 'E'))
                    ("Harbor Managers Office", ('A', 8))
                    ("Carved Wooden Elephant", (8, 'C'))
                |> Expect.equal False
        , test "can swap Brass Spyglass for Robot Parrot at Abandoned Lighthouse" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Brass Spyglass", (4, 'B'))
                    ("Abandoned Lighthouse", ('B', 4))
                    ("Robot Parrot", (1, 'C'))
                |> Expect.equal True
        , test "cannot swap Vintage Pirate Hat for Model Ship in Large Bottle at Old Schooner" <|
            \_ ->
                 specialCaseSwapPossible 
                    ("Vintage Pirate Hat", (7, 'E'))
                    ("Old Schooner", ('A', 6))
                    ("Model Ship in Large Bottle", (8, 'A'))
                |> Expect.equal False
        ]
