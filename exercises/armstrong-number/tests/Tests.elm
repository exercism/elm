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
        , test "Single digit numbers are Armstrong numbers" <|
            \_ ->
                Expect.equal True <|
                    isArmstrongNumber 5
        , test "There are no 2 digit Armstrong numbers" <|
            \_ ->
                Expect.equal False <|
                    isArmstrongNumber 10
        , test "Three digit number that is an Armstrong number" <|
            \_ ->
                Expect.equal True <|
                    isArmstrongNumber 153
        , test "Three digit number that is not an Armstrong number" <|
            \_ ->
                Expect.equal False <|
                    isArmstrongNumber 100
        , test "Four digit number that is an Armstrong number" <|
            \_ ->
                Expect.equal True <|
                    isArmstrongNumber 9474
        , test "Four digit number that is not an Armstrong number" <|
            \_ ->
                Expect.equal False <|
                    isArmstrongNumber 9475
        , test "Seven digit number that is an Armstrong number" <|
            \_ ->
                Expect.equal True <|
                    isArmstrongNumber 9926315
        , test "Seven digit number that is not an Armstrong number" <|
            \_ ->
                Expect.equal False <|
                    isArmstrongNumber 9926314
        ]
