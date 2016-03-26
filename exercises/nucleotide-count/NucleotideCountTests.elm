module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import NucleotideCount exposing (nucleotideCounts)


tests : Test
tests =
  suite
    "NucleotideCount"
    [ test
        "empty dna strand has no nucleotides"
        (assertEqual
          { a = 0, t = 0, c = 0, g = 0 }
          (nucleotideCounts "")
        )
    , test
        "repetitive-sequence-has-only-guanosine"
        (assertEqual
          { a = 0, t = 0, c = 0, g = 8 }
          (nucleotideCounts "GGGGGGGG")
        )
    , test
        "counts all nucleotides"
        (assertEqual
          { a = 20, t = 21, c = 12, g = 17 }
          (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
