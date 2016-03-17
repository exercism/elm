module NucleotideCountTest where

-- TODO - remove example inclusion once Problem sets are ready to go live or CI is set up.

import NucleotideCountExample exposing (nucleotideCounts)

import ElmTest.Test exposing (test, Test, suite)
import ElmTest.Assertion exposing (assert, assertEqual)
import ElmTest.Runner.Element exposing (runDisplay)

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

main = runDisplay tests
