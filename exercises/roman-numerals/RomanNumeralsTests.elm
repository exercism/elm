port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import RomanNumerals exposing (toRoman)


tests : Test
tests =
    describe "Roman Numerals"
        [ test "1" <|
            \() ->
                Expect.equal ("I")
                    (toRoman 1)
        , test "2" <|
            \() ->
                Expect.equal ("II")
                    (toRoman 2)
        , test "3" <|
            \() ->
                Expect.equal ("III")
                    (toRoman 3)
        , test "4" <|
            \() ->
                Expect.equal ("IV")
                    (toRoman 4)
        , test "5" <|
            \() ->
                Expect.equal ("V")
                    (toRoman 5)
        , test "6" <|
            \() ->
                Expect.equal ("VI")
                    (toRoman 6)
        , test "9" <|
            \() ->
                Expect.equal ("IX")
                    (toRoman 9)
        , test "27" <|
            \() ->
                Expect.equal ("XXVII")
                    (toRoman 27)
        , test "48" <|
            \() ->
                Expect.equal ("XLVIII")
                    (toRoman 48)
        , test "59" <|
            \() ->
                Expect.equal ("LIX")
                    (toRoman 59)
        , test "93" <|
            \() ->
                Expect.equal ("XCIII")
                    (toRoman 93)
        , test "141" <|
            \() ->
                Expect.equal ("CXLI")
                    (toRoman 141)
        , test "163" <|
            \() ->
                Expect.equal ("CLXIII")
                    (toRoman 163)
        , test "402" <|
            \() ->
                Expect.equal ("CDII")
                    (toRoman 402)
        , test "575" <|
            \() ->
                Expect.equal ("DLXXV")
                    (toRoman 575)
        , test "911" <|
            \() ->
                Expect.equal ("CMXI")
                    (toRoman 911)
        , test "1024" <|
            \() ->
                Expect.equal ("MXXIV")
                    (toRoman 1024)
        , test "3000" <|
            \() ->
                Expect.equal ("MMM")
                    (toRoman 3000)
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
