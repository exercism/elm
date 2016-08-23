port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import RNATranscription exposing (toRNA)


tests : Test
tests =
    describe "RNATranscription"
        [ test "complement of cytosine is guanine" <|
            \() -> Expect.equal (Ok "G") (toRNA "C")
        , test "complement of guanine is cytosine" <|
            \() -> Expect.equal (Ok "C") (toRNA "G")
        , test "complement of thymine is adenine" <|
            \() -> Expect.equal (Ok "A") (toRNA "T")
        , test "complement of adenine is uracil" <|
            \() -> Expect.equal (Ok "U") (toRNA "A")
        , test "complement" <|
            \() -> Expect.equal (Ok "UGCACCAGAAUU") (toRNA "ACGTGGTCTTAA")
        , test "correctly handles completely invalid input" <|
            \() -> Expect.equal (Err 'X') (toRNA "XXX")
        , test "correctly handles partially invalid input" <|
            \() -> Expect.equal (Err 'U') (toRNA "UGAAXXXGACAUG")
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
