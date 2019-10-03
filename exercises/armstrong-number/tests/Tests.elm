module Tests exposing (tests)

import Armstrong exposing (isArmstrongNumber)
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Series"
        [ test "Zero is an Armstrong number" <|
            \_ ->
                Expect.equal True <|
                    isArmstrongNumber 0
        , skip <|
            test "Single digit numbers are Armstrong numbers" <|
                \_ ->
                    Expect.equal True <|
                        isArmstrongNumber 5
        , skip <|
            test "There are no 2 digit Armstrong numbers" <|
                \_ ->
                    Expect.equal False <|
                        isArmstrongNumber 10
        , skip <|
            test "Three digit number that is an Armstrong number" <|
                \_ ->
                    Expect.equal True <|
                        isArmstrongNumber 153
        , skip <|
            test "Three digit number that is not an Armstrong number" <|
                \_ ->
                    Expect.equal False <|
                        isArmstrongNumber 100
        , skip <|
            test "Four digit number that is an Armstrong number" <|
                \_ ->
                    Expect.equal True <|
                        isArmstrongNumber 9474
        , skip <|
            test "Four digit number that is not an Armstrong number" <|
                \_ ->
                    Expect.equal False <|
                        isArmstrongNumber 9475
        , skip <|
            test "Seven digit number that is an Armstrong number" <|
                \_ ->
                    Expect.equal True <|
                        isArmstrongNumber 9926315
        , skip <|
            test "Seven digit number that is not an Armstrong number" <|
                \_ ->
                    Expect.equal False <|
                        isArmstrongNumber 9926314
        ]
