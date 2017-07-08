module Tests exposing (..)

import Test exposing (..)
import Expect
import Dict exposing (Dict)
import WordCount exposing (wordCount)


tests : Test
tests =
    describe "Word Count"
        [ test "count one word" <|
            \() ->
                Expect.equal [ ( "word", 1 ) ]
                    (wordCount "word" |> Dict.toList)
        , skip <|
            test "count one of each word" <|
                \() ->
                    Expect.equal [ ( "each", 1 ), ( "of", 1 ), ( "one", 1 ) ]
                        (wordCount "one of each" |> Dict.toList)
        , skip <|
            test "multiple occurrences of a word" <|
                \() ->
                    Expect.equal [ ( "blue", 1 ), ( "fish", 4 ), ( "one", 1 ), ( "red", 1 ), ( "two", 1 ) ]
                        (wordCount "one fish two fish red fish blue fish" |> Dict.toList)
        , skip <|
            test "ignore punctuation" <|
                \() ->
                    Expect.equal [ ( "as", 1 ), ( "car", 1 ), ( "carpet", 1 ), ( "java", 1 ), ( "javascript", 1 ) ]
                        (wordCount "car : carpet as java : javascript!!&@$%^&" |> Dict.toList)
        , skip <|
            test "include numbers" <|
                \() ->
                    Expect.equal [ ( "1", 1 ), ( "2", 1 ), ( "testing", 2 ) ]
                        (wordCount "testing, 1, 2 testing" |> Dict.toList)
        , skip <|
            test "normalize case" <|
                \() ->
                    Expect.equal [ ( "go", 3 ), ( "stop", 2 ) ]
                        (wordCount "go Go GO Stop stop" |> Dict.toList)
        ]
