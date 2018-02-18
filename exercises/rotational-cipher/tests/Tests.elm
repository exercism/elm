module Tests exposing (..)

import Test exposing (..)
import Expect
import RotationalCipher exposing (rotate)


tests : Test
tests =
    describe "RotationalCipher"
        [ test "rotate a by 1" <|
            \() ->
                Expect.equal "b" <| rotate "a" 1
        , skip <|
            test "rotate a by 26, same output as input" <|
                \() ->
                    Expect.equal "a" <| rotate "a" 26
        , skip <|
            test "rotate a by 0, same output as input" <|
                \() ->
                    Expect.equal "a" <| rotate "a" 0
        , skip <|
            test "rotate m by 13" <|
                \() ->
                    Expect.equal "z" <| rotate "m" 13
        , skip <|
            test "rotate n by 13 with wrap around alphabet" <|
                \() ->
                    Expect.equal "a" <| rotate "n" 13
        , skip <|
            test "rotate capital letters" <|
                \() ->
                    Expect.equal "TRL" <| rotate "OMG" 5
        , skip <|
            test "rotate spaces" <|
                \() ->
                    Expect.equal "T R L" <| rotate "O M G" 5
        , skip <|
            test "rotate numbers" <|
                \() ->
                    Expect.equal "Xiwxmrk 1 2 3 xiwxmrk" <| rotate "Testing 1 2 3 testing" 4
        , skip <|
            test "rotate punctuation" <|
                \() ->
                    Expect.equal "Gzo'n zvo, Bmviyhv!" <| rotate "Let's eat, Grandma!" 21
        , skip <|
            test "rotate all letters" <|
                \() ->
                    Expect.equal "Gur dhvpx oebja sbk whzcf bire gur ynml qbt." <| rotate "The quick brown fox jumps over the lazy dog." 13
        ]
