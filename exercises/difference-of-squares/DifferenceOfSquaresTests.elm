port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import DifferenceOfSquares exposing (squareOfSum, sumOfSquares, difference)


tests : Test
tests =
    describe "DifferenceOfSquares"
        [ describe "square the sum of the numbers up to the given number"
            [ test "square of sum 5" <|
                \() -> Expect.equal 225 (squareOfSum 5)
            , test "square of sum 10" <|
                \() -> Expect.equal 3025 (squareOfSum 10)
            , test "square of sum 100" <|
                \() -> Expect.equal 25502500 (squareOfSum 100)
            ]
        , describe "sum the squares of the numbers up to the given number"
            [ test "sum of squares 5" <|
                \() -> Expect.equal 55 (sumOfSquares 5)
            , test "sum of squares 10" <|
                \() -> Expect.equal 385 (sumOfSquares 10)
            , test "sum of squares 100" <|
                \() -> Expect.equal 338350 (sumOfSquares 100)
            ]
        , describe "subtract sum of squares from square of sums"
            [ test "difference of squares 0" <|
                \() -> Expect.equal 0 (difference 0)
            , test "difference of squares 5" <|
                \() -> Expect.equal 170 (difference 5)
            , test "difference of squares 10" <|
                \() -> Expect.equal 2640 (difference 10)
            , test "difference of squares 100" <|
                \() -> Expect.equal 25164150 (difference 100)
            ]
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
