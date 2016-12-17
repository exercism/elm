port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Hamming exposing (distance)


tests : Test
tests =
    describe "Hamming"
        [ test "identical strands" <|
            \() -> Expect.equal (Just 0) (distance "A" "A")
        , test "long identical strands" <|
            \() -> Expect.equal (Just 0) (distance "GGACTGA" "GGACTGA")
        , test "complete distance in single nucleotide strands" <|
            \() -> Expect.equal (Just 1) (distance "A" "G")
        , test "complete distance in small strands" <|
            \() -> Expect.equal (Just 2) (distance "AG" "CT")
        , test "small distance in small strands" <|
            \() -> Expect.equal (Just 1) (distance "AT" "CT")
        , test "small distance" <|
            \() -> Expect.equal (Just 1) (distance "GGACG" "GGTCG")
        , test "small distance in long strands" <|
            \() -> Expect.equal (Just 2) (distance "ACCAGGG" "ACTATGG")
        , test "non-unique character in first strand" <|
            \() -> Expect.equal (Just 1) (distance "AGA" "AGG")
        , test "non-unique character in second strand" <|
            \() -> Expect.equal (Just 1) (distance "AGG" "AGA")
        , test "large distance" <|
            \() -> Expect.equal (Just 4) (distance "GATACA" "GCATAA")
        , test "large distance in off-by-one strand" <|
            \() -> Expect.equal (Just 9) (distance "GGACGGATTCTG" "AGGACGGATTCT")
        , test "empty strands" <|
            \() -> Expect.equal (Just 0) (distance "" "")
        , test "disallow first strand longer" <|
            \() -> Expect.equal Nothing (distance "AATG" "AAA")
        , test "disallow second strand longer" <|
            \() -> Expect.equal Nothing (distance "ATA" "AGTG")
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
