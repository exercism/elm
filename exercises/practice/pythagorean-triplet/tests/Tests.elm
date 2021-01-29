module Tests exposing (tests)

import Expect
import PythagoreanTriplet exposing (triplets)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Pythagorean Triplets"
        [ test "triplets whose sum is 12" <|
            \() -> Expect.equal [ ( 3, 4, 5 ) ] (triplets 12)
        , skip <|
            test "triplets whose sum is 108" <|
                \() -> Expect.equal [ ( 27, 36, 45 ) ] (triplets 108)
        , skip <|
            test "triplets whose sum is 1000" <|
                \() -> Expect.equal [ ( 200, 375, 425 ) ] (triplets 1000)
        , skip <|
            test "no matching triplets for 1001" <|
                \() -> Expect.equal [] (triplets 1001)
        , skip <|
            test "returns all matching triplets" <|
                \() -> Expect.equal [ ( 9, 40, 41 ), ( 15, 36, 39 ) ] (triplets 90)
        , skip <|
            test "several matching triplets" <|
                \() ->
                    Expect.equal
                        [ ( 40, 399, 401 )
                        , ( 56, 390, 394 )
                        , ( 105, 360, 375 )
                        , ( 120, 350, 370 )
                        , ( 140, 336, 364 )
                        , ( 168, 315, 357 )
                        , ( 210, 280, 350 )
                        , ( 240, 252, 348 )
                        ]
                        (triplets 840)
        , skip <|
            test "triplets for large number" <|
                \() ->
                    Expect.equal
                        [ ( 1200, 14375, 14425 )
                        , ( 1875, 14000, 14125 )
                        , ( 5000, 12000, 13000 )
                        , ( 6000, 11250, 12750 )
                        , ( 7500, 10000, 12500 )
                        ]
                        (triplets 30000)
        ]
