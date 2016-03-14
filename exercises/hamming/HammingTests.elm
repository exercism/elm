module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import Hamming exposing (distance)


tests : Test
tests =
  suite
    "Hamming"
    [ test
        "identical strands"
        (assertEqual (distance "A" "A") (Just 0))
    , test
        "long identical strands"
        (assertEqual (distance "GGACTGA" "GGACTGA") (Just 0))
    , test
        "complete distance in single nucleotide strands"
        (assertEqual (distance "A" "G") (Just 1))
    , test
        "complete distance in small strands"
        (assertEqual (distance "AG" "CT") (Just 2))
    , test
        "small distance in small strands"
        (assertEqual (distance "AT" "CT") (Just 1))
    , test
        "small distance"
        (assertEqual (distance "GGACG" "GGTCG") (Just 1))
    , test
        "small distance in long strands"
        (assertEqual (distance "ACCAGGG" "ACTATGG") (Just 2))
    , test
        "non-unique character in first strand"
        (assertEqual (distance "AGA" "AGG") (Just 1))
    , test
        "non-unique character in second strand"
        (assertEqual (distance "AGG" "AGA") (Just 1))
    , test
        "large distance"
        (assertEqual (distance "GATACA" "GCATAA") (Just 4))
    , test
        "large distance in off-by-one strand"
        (assertEqual (distance "GGACGGATTCTG" "AGGACGGATTCT") (Just 9))
    , test
        "empty strands"
        (assertEqual (distance "" "") (Just 0))
    , test
        "disallow first strand longer"
        (assertEqual (distance "AATG" "AAA") Nothing)
    , test
        "disallow second strand longer"
        (assertEqual (distance "ATA" "AGTG") Nothing)
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
