module Tests exposing (tests)

import ArmstrongNumbers exposing (check)
import Expect
import String
import Test exposing (..)


tests : Test
tests =
    describe "{exercise}"
        [ test "Zero is an Armstrong number" <|
            \() ->
                Expect.equal True
                    (ArmstrongNumbers.check 0)
        , skip <|
            test "Single digit numbers are Armstrong numbers" <|
                \() ->
                    Expect.equal True
                        (ArmstrongNumbers.check 5)
        , skip <|
            test "There are no 2 digit Armstrong numbers" <|
                \() ->
                    Expect.equal False
                        (ArmstrongNumbers.check 10)
        , skip <|
            test "Three digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (ArmstrongNumbers.check 153)
        , skip <|
            test "Three digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (ArmstrongNumbers.check 100)
        , skip <|
            test "Four digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (ArmstrongNumbers.check 9474)
        , skip <|
            test "Four digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (ArmstrongNumbers.check 9475)
        , skip <|
            test "Seven digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (ArmstrongNumbers.check 9926315)
        , skip <|
            test "Seven digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (ArmstrongNumbers.check 9926314)
        ]
