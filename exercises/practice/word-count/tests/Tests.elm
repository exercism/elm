module Tests exposing (tests)

import Dict
import Expect
import Test exposing (..)
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
            test "handles cramped lists" <|
                \() ->
                    Expect.equal [ ( "one", 1 ), ( "three", 1 ), ( "two", 1 ) ]
                        (wordCount "one,two,three" |> Dict.toList)
        , skip <|
            test "handles expanded lists" <|
                \() ->
                    Expect.equal [ ( "one", 1 ), ( "three", 1 ), ( "two", 1 ) ]
                        (wordCount "one,\ntwo,\nthree" |> Dict.toList)
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
        , skip <|
            test "with apostrophes" <|
                \() ->
                    Expect.equal [ ( "cry", 1 ), ( "don't", 2 ), ( "first", 1 ), ( "laugh", 1 ), ( "then", 1 ) ]
                        (wordCount "First: don't laugh. Then: don't cry." |> Dict.toList)
        , skip <|
            test "with quotations" <|
                \() ->
                    Expect.equal [ ( "and", 1 ), ( "between", 1 ), ( "can't", 1 ), ( "joe", 1 ), ( "large", 2 ), ( "tell", 1 ) ]
                        (wordCount "Joe can't tell between 'large' and large." |> Dict.toList)
        , skip <|
            test "substrings from the beginning" <|
                \() ->
                    Expect.equal [ ( "a", 1 ), ( "and", 1 ), ( "app", 1 ), ( "apple", 1 ), ( "between", 1 ), ( "can't", 1 ), ( "joe", 1 ), ( "tell", 1 ) ]
                        (wordCount "Joe can't tell between app, apple and a." |> Dict.toList)
        , skip <|
            test "multiple spaces not detected as a word" <|
                \() ->
                    Expect.equal [ ( "multiple", 1 ), ( "whitespaces", 1 ) ]
                        (wordCount " multiple   whitespaces" |> Dict.toList)
        , skip <|
            test "alternating word separators not detected as a word" <|
                \() ->
                    Expect.equal [ ( "one", 1 ), ( "three", 1 ), ( "two", 1 ) ]
                        (wordCount ",\n,one,\n ,two \n 'three'" |> Dict.toList)
        ]
