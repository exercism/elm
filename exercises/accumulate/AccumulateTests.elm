module Main exposing (..)

import ElmTest exposing (..)
import Accumulate exposing (accumulate)
import String


square : Int -> Int
square x =
    x * x


tests : Test
tests =
    suite "Accumulate"
        [ test "[]] Accumulate"
            (assertEqual [] (accumulate square []))
        , test "square Accumulate"
            (assertEqual [ 1, 4, 9 ] (accumulate square [ 1, 2, 3 ]))
        , test "toUpper Accumulate"
            (assertEqual [ "HELLO", "WORLD" ] (accumulate String.toUpper [ "hello", "world" ]))
        , test "reverse Accumulate"
            (assertEqual [ "olleh", "dlrow" ] (accumulate String.reverse [ "hello", "world" ]))
        ]


main : Program Never
main =
    runSuite tests
