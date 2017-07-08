module Tests exposing (..)

import Test exposing (..)
import Expect
import Strain exposing (keep, discard)
import String


even : Int -> Bool
even number =
    number % 2 == 0


odd : Int -> Bool
odd number =
    number % 2 == 1


isFirstLetter : String -> String -> Bool
isFirstLetter letter word =
    (String.left 1 word) == letter


lessThanTen : comparable -> Bool
lessThanTen num =
    num < 10


tests : Test
tests =
    describe "Strain"
        [ test "empty keep" <|
            \() ->
                Expect.equal []
                    (keep lessThanTen [])
        , skip <|
            test "keep everything" <|
                \() ->
                    Expect.equal [ 1, 2, 3 ]
                        (keep lessThanTen [ 1, 2, 3 ])
        , skip <|
            test "keep first and last" <|
                \() ->
                    Expect.equal [ 1, 3 ]
                        (keep odd [ 1, 2, 3 ])
        , skip <|
            test "keep nothing" <|
                \() ->
                    Expect.equal []
                        (keep even [ 1, 3, 5, 7 ])
        , skip <|
            test "keep neither first nor last" <|
                \() ->
                    Expect.equal [ 2 ]
                        (keep even [ 1, 2, 3 ])
        , skip <|
            test "keep strings" <|
                \() ->
                    Expect.equal [ "zebra", "zombies", "zealot" ]
                        (keep (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        , skip <|
            test "empty discard" <|
                \() ->
                    Expect.equal []
                        (discard lessThanTen [])
        , skip <|
            test "discard everything" <|
                \() ->
                    Expect.equal []
                        (discard lessThanTen [ 1, 2, 3 ])
        , skip <|
            test "discard first and last" <|
                \() ->
                    Expect.equal [ 2 ]
                        (discard odd [ 1, 2, 3 ])
        , skip <|
            test "discard nothing" <|
                \() ->
                    Expect.equal [ 1, 3, 5, 7 ]
                        (discard even [ 1, 3, 5, 7 ])
        , skip <|
            test "discard neither first nor last" <|
                \() ->
                    Expect.equal [ 1, 3 ]
                        (discard even [ 1, 2, 3 ])
        , skip <|
            test "discard strings" <|
                \() ->
                    Expect.equal [ "apple", "banana", "cherimoya" ]
                        (discard (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        ]
