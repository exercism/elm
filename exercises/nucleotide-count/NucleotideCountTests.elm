module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import NucleotideCount exposing (nucleotideCounts, version)
import Dict


tests : Test
tests =
  suite
    "NucleotideCount"
    [ test
        "the solution is for the current version"
        (assertEqual 2 version)
    , test
        "empty dna strand has no nucleotides"
        (assertEqual
          [ ( 'A', 0 ), ( 'C', 0 ), ( 'G', 0 ), ( 'T', 0 ) ]
          (Dict.toList (nucleotideCounts ""))
        )
    , test
        "repetitive-sequence-has-only-guanosine"
        (assertEqual
          ([ ( 'A', 0 ), ( 'C', 0 ), ( 'G', 8 ), ( 'T', 0 ) ])
          (Dict.toList (nucleotideCounts "GGGGGGGG"))
        )
    , test
        "counts all nucleotides"
        (assertEqual
          [ ( 'A', 20 ), ( 'C', 12 ), ( 'G', 17 ), ( 'T', 21 ) ]
          (Dict.toList (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
