module Main exposing (..)

import ElmTest exposing (..)
import Raindrops exposing (raindrops)


tests : Test
tests =
    suite "Raindrops"
        [ test "1" (assertEqual "1" (raindrops 1))
        , test "3" (assertEqual "Pling" (raindrops 3))
        , test "5" (assertEqual "Plang" (raindrops 5))
        , test "7" (assertEqual "Plong" (raindrops 7))
        , test "6" (assertEqual "Pling" (raindrops 6))
        , test "9" (assertEqual "Pling" (raindrops 9))
        , test "10" (assertEqual "Plang" (raindrops 10))
        , test "14" (assertEqual "Plong" (raindrops 14))
        , test "15" (assertEqual "PlingPlang" (raindrops 15))
        , test "21" (assertEqual "PlingPlong" (raindrops 21))
        , test "25" (assertEqual "Plang" (raindrops 25))
        , test "35" (assertEqual "PlangPlong" (raindrops 35))
        , test "49" (assertEqual "Plong" (raindrops 49))
        , test "52" (assertEqual "52" (raindrops 52))
        , test "105" (assertEqual "PlingPlangPlong" (raindrops 105))
        ]


main : Program Never
main =
    runSuite tests
