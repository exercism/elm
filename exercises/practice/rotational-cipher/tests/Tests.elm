module Tests exposing (tests)

import Expect
import RotationalCipher
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "RotationalCipher"
        [ -- skip <|
          test "rotate a by 0, same output as input" <|
            \() ->
                RotationalCipher.rotate "a" 0
                    |> Expect.equal "a"
        , skip <|
            test "rotate a by 1" <|
                \() ->
                    RotationalCipher.rotate "a" 1
                        |> Expect.equal "b"
        , skip <|
            test "rotate a by 26, same output as input" <|
                \() ->
                    RotationalCipher.rotate "a" 26
                        |> Expect.equal "a"
        , skip <|
            test "rotate m by 13" <|
                \() ->
                    RotationalCipher.rotate "m" 13
                        |> Expect.equal "z"
        , skip <|
            test "rotate n by 13 with wrap around alphabet" <|
                \() ->
                    RotationalCipher.rotate "n" 13
                        |> Expect.equal "a"
        , skip <|
            test "rotate capital letters" <|
                \() ->
                    RotationalCipher.rotate "OMG" 5
                        |> Expect.equal "TRL"
        , skip <|
            test "rotate spaces" <|
                \() ->
                    RotationalCipher.rotate "O M G" 5
                        |> Expect.equal "T R L"
        , skip <|
            test "rotate numbers" <|
                \() ->
                    RotationalCipher.rotate "Testing 1 2 3 testing" 4
                        |> Expect.equal "Xiwxmrk 1 2 3 xiwxmrk"
        , skip <|
            test "rotate punctuation" <|
                \() ->
                    RotationalCipher.rotate "Let's eat, Grandma!" 21
                        |> Expect.equal "Gzo'n zvo, Bmviyhv!"
        , skip <|
            test "rotate all letters" <|
                \() ->
                    RotationalCipher.rotate "The quick brown fox jumps over the lazy dog." 13
                        |> Expect.equal "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
        ]
