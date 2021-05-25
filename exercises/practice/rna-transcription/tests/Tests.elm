module Tests exposing (tests)

import Expect
import RnaTranscription exposing (toRNA)
import Test exposing (..)


isErr : Result error value -> Bool
isErr result =
    case result of
        Ok _ ->
            False

        Err _ ->
            True


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
        , skip <|
            test "input \"INVALID\" should produce an error" <|
                \() -> Expect.true "expected an error message output. For example `Err \"Invalid input\"`" (toRNA "INVALID" |> isErr)
        ]
