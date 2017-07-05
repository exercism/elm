module Tests exposing (..)

import Test exposing (..)
import Expect
import Leap


tests : Test
tests =
    describe "Leap"
        [ test "leap year" <|
            \() -> Expect.equal True (Leap.isLeapYear 1996)
        , skip <|
            test "non-leap year" <|
                \() -> Expect.equal False (Leap.isLeapYear 1997)
        , skip <|
            test "non-leap even year" <|
                \() -> Expect.equal False (Leap.isLeapYear 1998)
        , skip <|
            test "century" <|
                \() -> Expect.equal False (Leap.isLeapYear 1900)
        , skip <|
            test "second century" <|
                \() -> Expect.equal False (Leap.isLeapYear 1800)
        , skip <|
            test "fourth century" <|
                \() -> Expect.equal True (Leap.isLeapYear 2400)
        , skip <|
            test "y2k" <|
                \() -> Expect.equal True (Leap.isLeapYear 2000)
        ]
