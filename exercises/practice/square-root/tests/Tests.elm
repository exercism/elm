module Tests exposing (tests)

import Expect
import SquareRoot
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "SquareRoot"
        [ test "root of 1" <|
            \() ->
                SquareRoot.squareRoot 1
                    |> Expect.equal 1
        , skip <|
            test "root of 4" <|
                \() ->
                    SquareRoot.squareRoot 4
                        |> Expect.equal 2
        , skip <|
            test "root of 25" <|
                \() ->
                    SquareRoot.squareRoot 25
                        |> Expect.equal 5
        , skip <|
            test "root of 81" <|
                \() ->
                    SquareRoot.squareRoot 81
                        |> Expect.equal 9
        , skip <|
            test "root of 196" <|
                \() ->
                    SquareRoot.squareRoot 196
                        |> Expect.equal 14
        , skip <|
            test "root of 65025" <|
                \() ->
                    SquareRoot.squareRoot 65025
                        |> Expect.equal 255
        ]
