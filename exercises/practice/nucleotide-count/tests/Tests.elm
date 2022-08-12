module Tests exposing (tests)

import Expect
import NucleotideCount exposing (nucleotideCounts)
import Test exposing (..)


tests : Test
tests =
    describe "NucleotideCount"
        [ test "empty strand" <|
            \() ->
                Expect.equal (Ok { a = 0, t = 0, c = 0, g = 0 })
                    (nucleotideCounts "")
        , test "can count one nucleotide in single-character input" <|
            \() ->
                Expect.equal (Ok { a = 0, t = 0, c = 0, g = 1 })
                    (nucleotideCounts "G")
        , test "strand with repeated nucleotide" <|
            \() ->
                Expect.equal (Ok { a = 0, t = 0, c = 0, g = 7 })
                    (nucleotideCounts "GGGGGGG")
        , test "strand with multiple nucleotides" <|
            \() ->
                Expect.equal (Ok { a = 20, t = 21, c = 12, g = 17 })
                    (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        , test "strand with invalid nucleotides" <|
            \() ->
                Expect.equal (Err "Invalid nucleotide in strand")
                    (nucleotideCounts "AGXXACT")
        ]
