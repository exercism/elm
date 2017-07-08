module Tests exposing (..)

import Test exposing (..)
import Expect
import DifferenceOfSquares exposing (squareOfSum, sumOfSquares, difference)


tests : Test
tests =
    describe "DifferenceOfSquares"
        [ describe "square the sum of the numbers up to the given number"
            [ test "square of sum 5" <|
                \() -> Expect.equal 225 (squareOfSum 5)
            , skip <|
                test "square of sum 10" <|
                    \() -> Expect.equal 3025 (squareOfSum 10)
            , skip <|
                test "square of sum 100" <|
                    \() -> Expect.equal 25502500 (squareOfSum 100)
            ]
        , describe "sum the squares of the numbers up to the given number"
            [ skip <|
                test "sum of squares 5" <|
                    \() -> Expect.equal 55 (sumOfSquares 5)
            , skip <|
                test "sum of squares 10" <|
                    \() -> Expect.equal 385 (sumOfSquares 10)
            , skip <|
                test "sum of squares 100" <|
                    \() -> Expect.equal 338350 (sumOfSquares 100)
            ]
        , describe "subtract sum of squares from square of sums"
            [ skip <|
                test "difference of squares 0" <|
                    \() -> Expect.equal 0 (difference 0)
            , skip <|
                test "difference of squares 5" <|
                    \() -> Expect.equal 170 (difference 5)
            , skip <|
                test "difference of squares 10" <|
                    \() -> Expect.equal 2640 (difference 10)
            , skip <|
                test "difference of squares 100" <|
                    \() -> Expect.equal 25164150 (difference 100)
            ]
        ]
