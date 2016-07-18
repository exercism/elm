module Main exposing (..)

import ElmTest exposing (..)
import Hamming exposing (distance)


tests : Test
tests =
    suite "Hamming"
        [ test "identical strands"
            (assertEqual (Just 0) (distance "A" "A"))
        , test "long identical strands"
            (assertEqual (Just 0) (distance "GGACTGA" "GGACTGA"))
        , test "complete distance in single nucleotide strands"
            (assertEqual (Just 1) (distance "A" "G"))
        , test "complete distance in small strands"
            (assertEqual (Just 2) (distance "AG" "CT"))
        , test "small distance in small strands"
            (assertEqual (Just 1) (distance "AT" "CT"))
        , test "small distance"
            (assertEqual (Just 1) (distance "GGACG" "GGTCG"))
        , test "small distance in long strands"
            (assertEqual (Just 2) (distance "ACCAGGG" "ACTATGG"))
        , test "non-unique character in first strand"
            (assertEqual (Just 1) (distance "AGA" "AGG"))
        , test "non-unique character in second strand"
            (assertEqual (Just 1) (distance "AGG" "AGA"))
        , test "large distance"
            (assertEqual (Just 4) (distance "GATACA" "GCATAA"))
        , test "large distance in off-by-one strand"
            (assertEqual (Just 9) (distance "GGACGGATTCTG" "AGGACGGATTCT"))
        , test "empty strands"
            (assertEqual (Just 0) (distance "" ""))
        , test "disallow first strand longer"
            (assertEqual Nothing (distance "AATG" "AAA"))
        , test "disallow second strand longer"
            (assertEqual Nothing (distance "ATA" "AGTG"))
        ]


main : Program Never
main =
    runSuite tests
