module Tests exposing (tests)

import Acronym exposing (abbreviate)
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Acronym"
        [ test "basic" <|
            \_ ->
                Expect.equal "PNG"
                    (abbreviate "Portable Network Graphics")
        , skip <|
            test "lowercase words" <|
                \_ ->
                    Expect.equal "ROR"
                        (abbreviate "Ruby on Rails")
        , skip <|
            test "punctuation" <|
                \_ ->
                    Expect.equal "FIFO"
                        (abbreviate "First In, First Out")
        , skip <|
            test "all caps word" <|
                \_ ->
                    Expect.equal "GIMP"
                        (abbreviate "GNU Image Manipulation Program")
        , skip <|
            test "punctuation without whitespace" <|
                \_ ->
                    Expect.equal "CMOS"
                        (abbreviate "Complementary metal-oxide semiconductor")
        ]
