module Tests exposing (..)

import Expect
import RunLengthEncoding exposing (decode, encode, version)
import Test exposing (..)


tests : Test
tests =
    describe "RunLengthEncoding"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , describe "run-length encode a string"
            [ test "empty string" <|
                \() -> Expect.equal "" (encode "")
            , skip <|
                test "single characters only are encoded without count" <|
                    \() -> Expect.equal "XYZ" (encode "XYZ")
            , skip <|
                test "string with no single characters" <|
                    \() -> Expect.equal "2A3B4C" (encode "AABBBCCCC")
            , skip <|
                test "single characters mixed with repeated characters" <|
                    \() ->
                        Expect.equal "12WB12W3B24WB"
                            (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
            , skip <|
                test "multiple whitespace mixed in string" <|
                    \() -> Expect.equal "2 hs2q q2w2 " (encode "  hsqq qww  ")
            , skip <|
                test "lowercase characters" <|
                    \() -> Expect.equal "2a3b4c" (encode "aabbbcccc")
            ]
        , describe "run-length decode a string"
            [ skip <|
                test "empty string" <|
                    \() -> Expect.equal "" (decode "")
            , skip <|
                test "single characters only" <|
                    \() -> Expect.equal "XYZ" (decode "XYZ")
            , skip <|
                test "string with no single characters" <|
                    \() -> Expect.equal "AABBBCCCC" (decode "2A3B4C")
            , skip <|
                test "single characters with repeated characters" <|
                    \() ->
                        Expect.equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                            (decode "12WB12W3B24WB")
            , skip <|
                test "multiple whitespace mixed in string" <|
                    \() -> Expect.equal "  hsqq qww  " (decode "2 hs2q q2w2 ")
            , skip <|
                test "lower case string" <|
                    \() -> Expect.equal "" (decode "")
            , skip <|
                test "with a x10 value" <|
                    \() ->
                        Expect.equal "WWWWWWWWWW"
                            (decode "10W")
            ]
        , describe "encode and then decode"
            [ skip <|
                test "encode followed by decode gives original string" <|
                    \() ->
                        Expect.equal "zzz ZZ  zZ"
                            (decode (encode "zzz ZZ  zZ"))
            ]
        ]
