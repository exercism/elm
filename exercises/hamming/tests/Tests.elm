module Tests exposing (..)

import Test exposing (..)
import Expect
import Hamming exposing (distance)


tests : Test
tests =
    describe "Hamming"
        [ test "identical strands" <|
            \() -> Expect.equal (Just 0) (distance "A" "A")
        , skip <|
            test "long identical strands" <|
                \() -> Expect.equal (Just 0) (distance "GGACTGA" "GGACTGA")
        , skip <|
            test "complete distance in single nucleotide strands" <|
                \() -> Expect.equal (Just 1) (distance "A" "G")
        , skip <|
            test "complete distance in small strands" <|
                \() -> Expect.equal (Just 2) (distance "AG" "CT")
        , skip <|
            test "small distance in small strands" <|
                \() -> Expect.equal (Just 1) (distance "AT" "CT")
        , skip <|
            test "small distance" <|
                \() -> Expect.equal (Just 1) (distance "GGACG" "GGTCG")
        , skip <|
            test "small distance in long strands" <|
                \() -> Expect.equal (Just 2) (distance "ACCAGGG" "ACTATGG")
        , skip <|
            test "non-unique character in first strand" <|
                \() -> Expect.equal (Just 1) (distance "AGA" "AGG")
        , skip <|
            test "non-unique character in second strand" <|
                \() -> Expect.equal (Just 1) (distance "AGG" "AGA")
        , skip <|
            test "large distance" <|
                \() -> Expect.equal (Just 4) (distance "GATACA" "GCATAA")
        , skip <|
            test "large distance in off-by-one strand" <|
                \() -> Expect.equal (Just 9) (distance "GGACGGATTCTG" "AGGACGGATTCT")
        , skip <|
            test "empty strands" <|
                \() -> Expect.equal (Just 0) (distance "" "")
        , skip <|
            test "disallow first strand longer" <|
                \() -> Expect.equal Nothing (distance "AATG" "AAA")
        , skip <|
            test "disallow second strand longer" <|
                \() -> Expect.equal Nothing (distance "ATA" "AGTG")
        ]
