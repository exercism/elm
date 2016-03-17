module Main (..) where

import Task
import Console
import ElmTest exposing (..)

import NucleotideCount exposing (nucleotideCounts)

tests : Test
tests = suite "NucleotideCount test suite"
      [
        test "empty dna strand has no nucleotides" (assertEqual [('A', 0), ('T', 0), ('C', 0), ('G', 0)]
                      (nucleotideCounts "")),
        test "repetitive-sequence-has-only-guanosine" (assertEqual [('A', 0), ('T', 0), ('C', 0), ('G', 8)]
                      (nucleotideCounts "GGGGGGGG")),
        test "counts all nucleotides" (assertEqual [('A', 20), ('T', 21), ('C', 12), ('G', 17)]
                      (nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))
      ]

port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
