module Tests exposing (..)

import Expect
import RNATranscription exposing (toRNA)
import Test exposing (..)


tests : Test
tests =
    describe "RNATranscription"
        [ test "complement of cytosine is guanine" <|
            \() -> Expect.equal (Ok "G") (toRNA "C")
        , skip <|
            test "complement of guanine is cytosine" <|
                \() -> Expect.equal (Ok "C") (toRNA "G")
        , skip <|
            test "complement of thymine is adenine" <|
                \() -> Expect.equal (Ok "A") (toRNA "T")
        , skip <|
            test "complement of adenine is uracil" <|
                \() -> Expect.equal (Ok "U") (toRNA "A")
        , skip <|
            test "complement" <|
                \() -> Expect.equal (Ok "UGCACCAGAAUU") (toRNA "ACGTGGTCTTAA")
        ]
