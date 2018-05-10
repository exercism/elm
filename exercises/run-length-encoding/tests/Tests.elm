module Tests exposing (..)

import Expect
import RunLengthEncoding exposing (decode, encode, version)
import Test exposing (..)


tests : Test
tests =
    describe "RunLengthEncoding"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "encode empty string" <|
            \() -> Expect.equal "" (encode "")
        , skip <|
            test "encode single characters only" <|
                \() -> Expect.equal "XYZ" (encode "XYZ")
        , skip <|
            test "encode multiple whitespace mixed in string" <|
                \() -> Expect.equal "2 hs2q q2w2 " (encode "  hsqq qww  ")
        , skip <|
            test "encode lowercase characters" <|
                \() -> Expect.equal "2a3b4c" (encode "aabbbcccc")
        , skip <|
            test "decode empty string" <|
                \() -> Expect.equal "" (decode "")
        , skip <|
            test "decode single characters only" <|
                \() -> Expect.equal "XYZ" (decode "XYZ")
        , skip <|
            test "decode multiple whitespace mixed in string" <|
                \() -> Expect.equal "  hsqq qww  " (decode "2 hs2q q2w2 ")
        , skip <|
            test "decode lower case string" <|
                \() -> Expect.equal "" (decode "")
        , skip <|
            test "encode string with no single characters" <|
                \() -> Expect.equal "2A3B4C" (encode "AABBBCCCC")
        , skip <|
            test "decode string with no single characters" <|
                \() -> Expect.equal "AABBBCCCC" (decode "2A3B4C")
        , skip <|
            test "encode single characters mixed with repeated characters" <|
                \() ->
                    Expect.equal "12WB12W3B24WB"
                        (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
        , skip <|
            test "decode single characters with repeated characters" <|
                \() ->
                    Expect.equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                        (decode "12WB12W3B24WB")
        , skip <|
            test "encode followed by decode gives original string" <|
                \() ->
                    Expect.equal "zzz ZZ  zZ"
                        (decode (encode "zzz ZZ  zZ"))
        , skip <|
            test "decode with a x10 value" <|
                \() ->
                    Expect.equal "WWWWWWWWWW"
                        (decode "10W")
        ]
