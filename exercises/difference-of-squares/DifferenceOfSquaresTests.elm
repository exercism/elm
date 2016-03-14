module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import DifferenceOfSquares exposing (squareOfSum, sumOfSquares, difference)


tests : Test
tests =
  suite
    "DifferenceOfSquares"
    [ suite
        "square the sum of the numbers up to the given number"
        [ test "square of sum 5" (assertEqual 225 (squareOfSum 5))
        , test "square of sum 10" (assertEqual 3025 (squareOfSum 10))
        , test "square of sum 100" (assertEqual 25502500 (squareOfSum 100))
        ]
    , suite
        "sum the squares of the numbers up to the given number"
        [ test "sum of squares 5" (assertEqual 55 (sumOfSquares 5))
        , test "sum of squares 10" (assertEqual 385 (sumOfSquares 10))
        , test "sum of squares 100" (assertEqual 338350 (sumOfSquares 100))
        ]
    , suite
        "subtract sum of squares from square of sums"
        [ test "difference of squares 0" (assertEqual 0 (difference 0))
        , test "difference of squares 5" (assertEqual 170 (difference 5))
        , test "difference of squares 10" (assertEqual 2640 (difference 10))
        , test "difference of squares 100" (assertEqual 25164150 (difference 100))
        ]
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
