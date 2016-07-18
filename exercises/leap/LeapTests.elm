module Main exposing (..)

import ElmTest exposing (..)
import Leap


tests : Test
tests =
    suite "Leap"
        [ test "leap year" (assertEqual True (Leap.isLeapYear 1996))
        , test "non-leap year" (assertEqual False (Leap.isLeapYear 1997))
        , test "non-leap even year" (assertEqual False (Leap.isLeapYear 1998))
        , test "century" (assertEqual False (Leap.isLeapYear 1900))
        , test "second century" (assertEqual False (Leap.isLeapYear 1800))
        , test "fourth century" (assertEqual True (Leap.isLeapYear 2400))
        , test "y2k" (assertEqual True (Leap.isLeapYear 2000))
        ]


main : Program Never
main =
    runSuite tests
