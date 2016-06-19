module Main exposing (..)

import ElmTest exposing (..)
import RunLengthEncoding exposing (version, decode, encode)


tests : Test
tests =
    suite "RunLengthEncoding"
        [ test "the solution is for the correct version of the test"
            (assertEqual 2 version)
        , test "encode simple"
            (assertEqual "2A3B4C" (encode "AABBBCCCC"))
        , test "decode simple"
            (assertEqual "AABBBCCCC" (decode "2A3B4C"))
        , test "encode with single values"
            (assertEqual "12WB12W3B24WB"
                (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
            )
        , test "decode with single values"
            (assertEqual "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                (decode "12WB12W3B24WB")
            )
        , test "(decode (encode (...)) combination"
            (assertEqual "zzz ZZ  zZ"
                (decode (encode "zzz ZZ  zZ"))
            )
        , test "decode with a x10 value"
            (assertEqual "WWWWWWWWWW"
                (decode "10W")
            )
        , test "encode unicode"
            (assertEqual "⏰3⚽2⭐⏰" (encode "⏰⚽⚽⚽⭐⭐⏰"))
        , test "decode unicode"
            (assertEqual "⏰⚽⚽⚽⭐⭐⏰" (decode "⏰3⚽2⭐⏰"))
        ]


main : Program Never
main =
    runSuite tests
