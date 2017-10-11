module Tests exposing (..)

import Test exposing (..)
import Expect
import Isogram exposing (isIsogram)


tests : Test
tests =
    describe "Isogram"
        [ test "empty string" <|
            \() ->
                Expect.equal True <| isIsogram ""
        , test "isogram with only lower case characters" <|
            \() ->
                Expect.equal True <| isIsogram "isogram"
        , test "word with one duplicated character" <|
            \() ->
                Expect.equal False <| isIsogram "eleven"
        , test "longest reported english isogram" <|
            \() ->
                Expect.equal True <| isIsogram "subdermatoglyphic"
        , test "word with duplicated character in mixed case" <|
            \() ->
                Expect.equal False <| isIsogram "Alphabet"
        , test "hypothetical isogrammic word with hyphen" <|
            \() ->
                Expect.equal True <| isIsogram "thumbscrew-japingly"
        , test "isogram with duplicated non letter character" <|
            \() ->
                Expect.equal True <| isIsogram "Hjelmqvist-Gryb-Zock-Pfund-Wax"
        , test "made-up name that is an isogram" <|
            \() ->
                Expect.equal True <| isIsogram "Emily Jung Schwartzkopf"
        , test "duplicated character in the middle" <|
            \() ->
                Expect.equal False <| isIsogram "accentor"
        ]
