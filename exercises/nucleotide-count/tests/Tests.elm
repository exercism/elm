module Tests exposing (..)

import Test exposing (..)
import Expect
import NucleotideCount exposing (nucleotideCounts, version)


tests : Test
tests =
    describe "NucleotideCount"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "empty dna strand has no nucleotides" <|
            \() ->
                Expect.equal { a = 0, t = 0, c = 0, g = 0 }
                    (nucleotideCounts "")
        , skip <|
            test "repetitive sequence has only guanine" <|
                \() ->
                    Expect.equal { a = 0, t = 0, c = 0, g = 8 }
                        (nucleotideCounts "GGGGGGGG")
        , skip <|
            test "counts all nucleotides" <|
                \() ->
                    Expect.equal { a = 20, t = 21, c = 12, g = 17 }
                        (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        ]
