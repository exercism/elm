module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import NucleotideCount exposing (nucleotideCounts)


sorted =
  List.sortBy fst


tests : Test
tests =
  suite
    "NucleotideCount"
    [ test
        "empty dna strand has no nucleotides"
        (assertEqual
          [ ( 'A', 0 ), ( 'C', 0 ), ( 'G', 0 ), ( 'T', 0 ) ]
          (sorted (nucleotideCounts ""))
        )
    , test
        "repetitive-sequence-has-only-guanosine"
        (assertEqual
          [ ( 'A', 0 ), ( 'C', 0 ), ( 'G', 8 ), ( 'T', 0 ) ]
          (sorted (nucleotideCounts "GGGGGGGG"))
        )
    , test
        "counts all nucleotides"
        (assertEqual
          [ ( 'A', 20 ), ( 'C', 12 ), ( 'G', 17 ), ( 'T', 21 ) ]
          (sorted (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
