module Tests exposing (tests)

import ArmstrongNumbers exposing (isArmstrongNumber)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "{exercise}"
        [ test "Zero is an Armstrong number" <|
            \() ->
                Expect.equal True
                    (isArmstrongNumber 0)
        , skip <|
            test "Single digit numbers are Armstrong numbers" <|
                \() ->
                    Expect.equal True
                        (isArmstrongNumber 5)
        , skip <|
            test "There are no 2 digit Armstrong numbers" <|
                \() ->
                    Expect.equal False
                        (isArmstrongNumber 10)
        , skip <|
            test "Three digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (isArmstrongNumber 153)
        , skip <|
            test "Three digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (isArmstrongNumber 100)
        , skip <|
            test "Four digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (isArmstrongNumber 9474)
        , skip <|
            test "Four digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (isArmstrongNumber 9475)
        , skip <|
            test "Seven digit number that is an Armstrong number" <|
                \() ->
                    Expect.equal True
                        (isArmstrongNumber 9926315)
        , skip <|
            test "Seven digit number that is not an Armstrong number" <|
                \() ->
                    Expect.equal False
                        (isArmstrongNumber 9926314)
        ]
