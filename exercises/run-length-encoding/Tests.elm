port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import RunLengthEncoding exposing (version, decode, encode)


tests : Test
tests =
    describe "RunLengthEncoding"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "encode simple" <|
            \() -> Expect.equal "2A3B4C" (encode "AABBBCCCC")
        , test "decode simple" <|
            \() -> Expect.equal "AABBBCCCC" (decode "2A3B4C")
        , test "encode with single values" <|
            \() ->
                Expect.equal "12WB12W3B24WB"
                    (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
        , test "decode with single values" <|
            \() ->
                Expect.equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                    (decode "12WB12W3B24WB")
        , test "(decode (encode (...)) combination" <|
            \() ->
                Expect.equal "zzz ZZ  zZ"
                    (decode (encode "zzz ZZ  zZ"))
        , test "decode with a x10 value" <|
            \() ->
                Expect.equal "WWWWWWWWWW"
                    (decode "10W")
        , test "encode unicode" <|
            \() -> Expect.equal "⏰3⚽2⭐⏰" (encode "⏰⚽⚽⚽⭐⭐⏰")
        , test "decode unicode" <|
            \() -> Expect.equal "⏰⚽⚽⚽⭐⭐⏰" (decode "⏰3⚽2⭐⏰")
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
