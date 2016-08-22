port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Leap


tests : Test
tests =
    describe "Leap"
        [ test "leap year" <|
            \() -> Expect.equal True (Leap.isLeapYear 1996)
        , test "non-leap year" <|
            \() -> Expect.equal False (Leap.isLeapYear 1997)
        , test "non-leap even year" <|
            \() -> Expect.equal False (Leap.isLeapYear 1998)
        , test "century" <|
            \() -> Expect.equal False (Leap.isLeapYear 1900)
        , test "second century" <|
            \() -> Expect.equal False (Leap.isLeapYear 1800)
        , test "fourth century" <|
            \() -> Expect.equal True (Leap.isLeapYear 2400)
        , test "y2k" <|
            \() -> Expect.equal True (Leap.isLeapYear 2000)
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
