module Main exposing (..)

import ElmTest exposing (..)
import NucleotideCount exposing (nucleotideCounts, version)


tests : Test
tests =
    suite "NucleotideCount"
        [ test "the solution is for the correct version of the test"
            (assertEqual 2 version)
        , test "empty dna strand has no nucleotides"
            (assertEqual { a = 0, t = 0, c = 0, g = 0 }
                (nucleotideCounts "")
            )
        , test "repetitive-sequence-has-only-guanosine"
            (assertEqual { a = 0, t = 0, c = 0, g = 8 }
                (nucleotideCounts "GGGGGGGG")
            )
        , test "counts all nucleotides"
            (assertEqual { a = 20, t = 21, c = 12, g = 17 }
                (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
            )
        ]


main : Program Never
main =
    runSuite tests
