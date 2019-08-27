module Tests exposing (tests)

import MatchingBrackets exposing (isPaired)
import Expect
import String
import Test exposing (..)


tests : Test
tests =
    describe "MatchingBrackets"
        [ test "paired square brackets" <|
            \_ ->
                Expect.equal True (isPaired "[]")
        , skip <|
            test "empty string" <|
                \_ ->
                    Expect.equal True (isPaired "")
        , skip <|
            test "unpaired brackets" <|
                \_ ->
                    Expect.equal False (isPaired "[[")
        , skip <|
            test "wrong ordered brackets" <|
                \_ ->
                    Expect.equal False (isPaired "}{")
        , skip <|
            test "wrong closing bracket" <|
                \_ ->
                    Expect.equal False (isPaired "{]")
        , skip <|
            test "paired with whitespace" <|
                \_ ->
                    Expect.equal True (isPaired "{ }")
        , skip <|
            test "partially paired brackets" <|
                \_ ->
                    Expect.equal False (isPaired "{[])")
        , skip <|
            test "simple nested brackets" <|
                \_ ->
                    Expect.equal True (isPaired "{[]}")
        , skip <|
            test "seceral paired brackets" <|
                \_ ->
                    Expect.equal True (isPaired "{}[]")
        , skip <|
            test "paired and nested brackets" <|
                \_ ->
                    Expect.equal True (isPaired "([{}({}[])])")
        , skip <|
            test "unopened closing brackets" <|
                \_ ->
                    Expect.equal False (isPaired "{[)][]}")
        , skip <|
            test "unpaired and nested brackets" <|
                \_ ->
                    Expect.equal False (isPaired "([{])")
        , skip <|
            test "paired and wrong nested brackets" <|
                \_ ->
                    Expect.equal False (isPaired "[({]})")
        , skip <|
            test "math expression" <|
                \_ ->
                    Expect.equal True (isPaired "(((185 + 223.85) * 15) - 543)/2")
        , skip <|
            test "complex latex expression" <|
                \_ ->
                    Expect.equal True (isPaired "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
        ]
