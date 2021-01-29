module Tests exposing (tests)

import Expect
import Test exposing (..)
import Wordy exposing (answer)


tests : Test
tests =
    describe "Wordy"
        [ test "just a number" <|
            \() ->
                Expect.equal (Just 5) <| answer "What is 5?"
        , skip <|
            test "addition" <|
                \() ->
                    Expect.equal (Just 2) <| answer "What is 1 plus 1?"
        , skip <|
            test "more addition" <|
                \() ->
                    Expect.equal (Just 55) <| answer "What is 53 plus 2?"
        , skip <|
            test "addition with negative numbers" <|
                \() ->
                    Expect.equal (Just -11) <| answer "What is -1 plus -10?"
        , skip <|
            test "large addition" <|
                \() ->
                    Expect.equal (Just 45801) <| answer "What is 123 plus 45678?"
        , skip <|
            test "subtraction" <|
                \() ->
                    Expect.equal (Just 16) <| answer "What is 4 minus -12?"
        , skip <|
            test "multiplication" <|
                \() ->
                    Expect.equal (Just -75) <| answer "What is -3 multiplied by 25?"
        , skip <|
            test "division" <|
                \() ->
                    Expect.equal (Just -11) <| answer "What is 33 divided by -3?"
        , skip <|
            test "multiple additions" <|
                \() ->
                    Expect.equal (Just 3) <| answer "What is 1 plus 1 plus 1?"
        , skip <|
            test "addition and subtraction" <|
                \() ->
                    Expect.equal (Just 8) <| answer "What is 1 plus 5 minus -2?"
        , skip <|
            test "multiple subtraction" <|
                \() ->
                    Expect.equal (Just 3) <| answer "What is 20 minus 4 minus 13?"
        , skip <|
            test "subtraction then addition" <|
                \() ->
                    Expect.equal (Just 14) <| answer "What is 17 minus 6 plus 3?"
        , skip <|
            test "multiple multiplication" <|
                \() ->
                    Expect.equal (Just -12) <| answer "What is 2 multiplied by -2 multiplied by 3?"
        , skip <|
            test "addition and multiplication" <|
                \() ->
                    Expect.equal (Just -8) <| answer "What is -3 plus 7 multiplied by -2?"
        , skip <|
            test "multiple division" <|
                \() ->
                    Expect.equal (Just 2) <| answer "What is -12 divided by 2 divided by -3?"
        , skip <|
            test "unknown operation" <|
                \() ->
                    Expect.equal Nothing <| answer "What is 52 cubed?"
        , skip <|
            test "Non math question" <|
                \() ->
                    Expect.equal Nothing <| answer "Who is the President of the United States?"
        , skip <|
            test "reject problem missing an operand" <|
                \() ->
                    Expect.equal Nothing <| answer "What is 1 plus?"
        , skip <|
            test "reject problem with no operands or operators" <|
                \() ->
                    Expect.equal Nothing <| answer "What is?"
        , skip <|
            test "reject two operations in a row" <|
                \() ->
                    Expect.equal Nothing <| answer "What is 1 plus plus 2?"
        , skip <|
            test "reject two numbers in a row" <|
                \() ->
                    Expect.equal Nothing <| answer "What is 1 plus 2 1?"
        , skip <|
            test "reject postfix notation" <|
                \() ->
                    Expect.equal Nothing <| answer "What is 1 2 plus?"
        , skip <|
            test "reject prefix notation" <|
                \() ->
                    Expect.equal Nothing <| answer "What is plus 1 2?"
        ]
