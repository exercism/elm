module Main exposing (..)

import ElmTest exposing (..)
import RomanNumerals exposing (toRoman)


tests : Test
tests =
    suite "Roman Numerals"
        [ test "1"
            (assertEqual ("I")
                (toRoman 1)
            )
        , test "2"
            (assertEqual ("II")
                (toRoman 2)
            )
        , test "3"
            (assertEqual ("III")
                (toRoman 3)
            )
        , test "4"
            (assertEqual ("IV")
                (toRoman 4)
            )
        , test "5"
            (assertEqual ("V")
                (toRoman 5)
            )
        , test "6"
            (assertEqual ("VI")
                (toRoman 6)
            )
        , test "9"
            (assertEqual ("IX")
                (toRoman 9)
            )
        , test "27"
            (assertEqual ("XXVII")
                (toRoman 27)
            )
        , test "48"
            (assertEqual ("XLVIII")
                (toRoman 48)
            )
        , test "59"
            (assertEqual ("LIX")
                (toRoman 59)
            )
        , test "93"
            (assertEqual ("XCIII")
                (toRoman 93)
            )
        , test "141"
            (assertEqual ("CXLI")
                (toRoman 141)
            )
        , test "163"
            (assertEqual ("CLXIII")
                (toRoman 163)
            )
        , test "402"
            (assertEqual ("CDII")
                (toRoman 402)
            )
        , test "575"
            (assertEqual ("DLXXV")
                (toRoman 575)
            )
        , test "911"
            (assertEqual ("CMXI")
                (toRoman 911)
            )
        , test "1024"
            (assertEqual ("MXXIV")
                (toRoman 1024)
            )
        , test "3000"
            (assertEqual ("MMM")
                (toRoman 3000)
            )
        ]

main : Program Never
main =
    runSuite tests
