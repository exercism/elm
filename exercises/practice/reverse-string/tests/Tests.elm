module Tests exposing (tests)

import Expect
import ReverseString exposing (reverse)
import Test exposing (..)


tests : Test
tests =
    describe "ReverseString"
        [ test "an empty string" <|
            \() -> Expect.equal "" (reverse "")
        , skip <|
            test "a word" <|
                \() -> Expect.equal "tobor" (reverse "robot")
        , skip <|
            test "a capitalized word" <|
                \() -> Expect.equal "nemaR" (reverse "Ramen")
        , skip <|
            test "a sentence with punctuation" <|
                \() -> Expect.equal "!yrgnuh m'I" (reverse "I'm hungry!")
        , skip <|
            test "a palindrme" <|
                \() -> Expect.equal "racecar" (reverse "racecar")
        , skip <|
            test "an even-sized word" <|
                \() -> Expect.equal "reward" (reverse "drawer")
        ]
