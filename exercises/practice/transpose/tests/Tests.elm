module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, skip, test)
import Transpose exposing (transpose)


tests : Test
tests =
    describe "Transpose"
        [ test "empty string" <|
            \_ ->
                Expect.equal [] (transpose [])
        , skip <|
            test "two characters in a row" <|
                \_ ->
                    Expect.equal
                        [ "A"
                        , "1"
                        ]
                        (transpose [ "A1" ])
        , skip <|
            test "two characters in a column" <|
                \_ ->
                    Expect.equal
                        [ "A1" ]
                        (transpose
                            [ "A"
                            , "1"
                            ]
                        )
        , skip <|
            test "simple" <|
                \_ ->
                    Expect.equal
                        [ "A1"
                        , "B2"
                        , "C3"
                        ]
                        (transpose
                            [ "ABC"
                            , "123"
                            ]
                        )
        , skip <|
            test "single line" <|
                \_ ->
                    Expect.equal
                        [ "S"
                        , "i"
                        , "n"
                        , "g"
                        , "l"
                        , "e"
                        , " "
                        , "l"
                        , "i"
                        , "n"
                        , "e"
                        , "."
                        ]
                        (transpose [ "Single line." ])
        , skip <|
            test "first line longer than second line" <|
                \_ ->
                    Expect.equal
                        [ "TT"
                        , "hh"
                        , "ee"
                        , "  "
                        , "ff"
                        , "oi"
                        , "uf"
                        , "rt"
                        , "th"
                        , "h "
                        , " l"
                        , "li"
                        , "in"
                        , "ne"
                        , "e."
                        , "."
                        ]
                        (transpose
                            [ "The fourth line."
                            , "The fifth line."
                            ]
                        )
        , skip <|
            test "second line longer than first line" <|
                \_ ->
                    Expect.equal
                        [ "TT"
                        , "hh"
                        , "ee"
                        , "  "
                        , "fs"
                        , "ie"
                        , "rc"
                        , "so"
                        , "tn"
                        , " d"
                        , "l "
                        , "il"
                        , "ni"
                        , "en"
                        , ".e"
                        , " ."
                        ]
                        (transpose
                            [ "The first line."
                            , "The second line."
                            ]
                        )
        , skip <|
            test "mixed line length" <|
                \_ ->
                    Expect.equal
                        [ "TAAA"
                        , "h   "
                        , "elll"
                        , " ooi"
                        , "lnnn"
                        , "ogge"
                        , "n e."
                        , "glr"
                        , "ei "
                        , "snl"
                        , "tei"
                        , " .n"
                        , "l e"
                        , "i ."
                        , "n"
                        , "e"
                        , "."
                        ]
                        (transpose
                            [ "The longest line."
                            , "A long line."
                            , "A longer line."
                            , "A line."
                            ]
                        )
        , skip <|
            test "square" <|
                \_ ->
                    Expect.equal
                        [ "HEART"
                        , "EMBER"
                        , "ABUSE"
                        , "RESIN"
                        , "TREND"
                        ]
                        (transpose
                            [ "HEART"
                            , "EMBER"
                            , "ABUSE"
                            , "RESIN"
                            , "TREND"
                            ]
                        )
        , skip <|
            test "rectangle" <|
                \_ ->
                    Expect.equal
                        [ "FOBS"
                        , "RULE"
                        , "ATOP"
                        , "CLOT"
                        , "TIME"
                        , "UNIT"
                        , "RENT"
                        , "EDGE"
                        ]
                        (transpose
                            [ "FRACTURE"
                            , "OUTLINED"
                            , "BLOOMING"
                            , "SEPTETTE"
                            ]
                        )
        , skip <|
            test "triangle" <|
                \_ ->
                    Expect.equal
                        [ "TEASER"
                        , " EASER"
                        , "  ASER"
                        , "   SER"
                        , "    ER"
                        , "     R"
                        ]
                        (transpose
                            [ "T"
                            , "EE"
                            , "AAA"
                            , "SSSS"
                            , "EEEEE"
                            , "RRRRRR"
                            ]
                        )
        , skip <|
            test "jagged triangle" <|
                \_ ->
                    Expect.equal
                        [ "123456"
                        , "1 3456"
                        , "  3456"
                        , "  3 56"
                        , "    56"
                        , "    5"
                        ]
                        (transpose
                            [ "11"
                            , "2"
                            , "3333"
                            , "444"
                            , "555555"
                            , "66666"
                            ]
                        )
        ]
