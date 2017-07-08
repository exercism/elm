module Tests exposing (..)

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
        , skip <|
            test "decode simple" <|
                \() -> Expect.equal "AABBBCCCC" (decode "2A3B4C")
        , skip <|
            test "encode with single values" <|
                \() ->
                    Expect.equal "12WB12W3B24WB"
                        (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
        , skip <|
            test "decode with single values" <|
                \() ->
                    Expect.equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                        (decode "12WB12W3B24WB")
        , skip <|
            test "(decode (encode (...)) combination" <|
                \() ->
                    Expect.equal "zzz ZZ  zZ"
                        (decode (encode "zzz ZZ  zZ"))
        , skip <|
            test "decode with a x10 value" <|
                \() ->
                    Expect.equal "WWWWWWWWWW"
                        (decode "10W")
        , skip <|
            test "encode unicode" <|
                \() -> Expect.equal "⏰3⚽2⭐⏰" (encode "⏰⚽⚽⚽⭐⭐⏰")
        , skip <|
            test "decode unicode" <|
                \() -> Expect.equal "⏰⚽⚽⚽⭐⭐⏰" (decode "⏰3⚽2⭐⏰")
        ]
