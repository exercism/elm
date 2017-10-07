module Tests exposing (..)

import Expect
import Test exposing (..)
import Triangle exposing (rows)


tests : Test
tests =
    describe "Triangle"
        [ test "no rows" <|
            \() ->
                Expect.equal [] (rows 0)
        , skip <|
            test "single row" <|
                \() ->
                    Expect.equal [ [ 1 ] ] (rows 1)
        , skip <|
            test "two rows" <|
                \() ->
                    Expect.equal [ [ 1 ], [ 1, 1 ] ] (rows 2)
        , skip <|
            test "three rows" <|
                \() ->
                    Expect.equal [ [ 1 ], [ 1, 1 ], [ 1, 2, 1 ] ] (rows 3)
        , skip <|
            test "four rows" <|
                \() ->
                    Expect.equal [ [ 1 ], [ 1, 1 ], [ 1, 2, 1 ], [ 1, 3, 3, 1 ] ] (rows 4)
        , skip <|
            test "negative rows" <|
                \() ->
                    Expect.equal [] (rows -1)
        ]
