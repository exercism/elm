module Tests exposing (tests)

import Expect
import PigLatin
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "PigLatin"
        [ describe "ay is added to words that start with vowels"
            [ -- skip <|
              test "word beginning with a" <|
                \() ->
                    PigLatin.translate "apple"
                        |> Expect.equal "appleay"
            , skip <|
                test "word beginning with e" <|
                    \() ->
                        PigLatin.translate "ear"
                            |> Expect.equal "earay"
            , skip <|
                test "word beginning with i" <|
                    \() ->
                        PigLatin.translate "igloo"
                            |> Expect.equal "iglooay"
            , skip <|
                test "word beginning with o" <|
                    \() ->
                        PigLatin.translate "object"
                            |> Expect.equal "objectay"
            , skip <|
                test "word beginning with u" <|
                    \() ->
                        PigLatin.translate "under"
                            |> Expect.equal "underay"
            , skip <|
                test "word beginning with a vowel and followed by a qu" <|
                    \() ->
                        PigLatin.translate "equal"
                            |> Expect.equal "equalay"
            ]
        , describe "first letter and ay are moved to the end of words that start with consonants"
            [ skip <|
                test "word beginning with p" <|
                    \() ->
                        PigLatin.translate "pig"
                            |> Expect.equal "igpay"
            , skip <|
                test "word beginning with k" <|
                    \() ->
                        PigLatin.translate "koala"
                            |> Expect.equal "oalakay"
            , skip <|
                test "word beginning with x" <|
                    \() ->
                        PigLatin.translate "xenon"
                            |> Expect.equal "enonxay"
            , skip <|
                test "word beginning with q without a following u" <|
                    \() ->
                        PigLatin.translate "qat"
                            |> Expect.equal "atqay"
            , skip <|
                test "word beginning with consonant and vowel containing qu" <|
                    \() ->
                        PigLatin.translate "liquid"
                            |> Expect.equal "iquidlay"
            ]
        , describe "some letter clusters are treated like a single consonant"
            [ skip <|
                test "word beginning with ch" <|
                    \() ->
                        PigLatin.translate "chair"
                            |> Expect.equal "airchay"
            , skip <|
                test "word beginning with qu" <|
                    \() ->
                        PigLatin.translate "queen"
                            |> Expect.equal "eenquay"
            , skip <|
                test "word beginning with qu and a preceding consonant" <|
                    \() ->
                        PigLatin.translate "square"
                            |> Expect.equal "aresquay"
            , skip <|
                test "word beginning with th" <|
                    \() ->
                        PigLatin.translate "therapy"
                            |> Expect.equal "erapythay"
            , skip <|
                test "word beginning with thr" <|
                    \() ->
                        PigLatin.translate "thrush"
                            |> Expect.equal "ushthray"
            , skip <|
                test "word beginning with sch" <|
                    \() ->
                        PigLatin.translate "school"
                            |> Expect.equal "oolschay"
            ]
        , describe "some letter clusters are treated like a single vowel"
            [ skip <|
                test "word beginning with yt" <|
                    \() ->
                        PigLatin.translate "yttria"
                            |> Expect.equal "yttriaay"
            , skip <|
                test "word beginning with xr" <|
                    \() ->
                        PigLatin.translate "xray"
                            |> Expect.equal "xrayay"
            ]
        , describe "position of y in a word determines if it is a consonant or a vowel"
            [ skip <|
                test "y is treated like a consonant at the beginning of a word" <|
                    \() ->
                        PigLatin.translate "yellow"
                            |> Expect.equal "ellowyay"
            , skip <|
                test "y is treated like a vowel at the end of a consonant cluster" <|
                    \() ->
                        PigLatin.translate "rhythm"
                            |> Expect.equal "ythmrhay"
            , skip <|
                test "y as second letter in two letter word" <|
                    \() ->
                        PigLatin.translate "my"
                            |> Expect.equal "ymay"
            ]
        , describe "phrases are translated"
            [ skip <|
                test "a whole phrase" <|
                    \() ->
                        PigLatin.translate "quick fast run"
                            |> Expect.equal "ickquay astfay unray"
            ]
        ]
