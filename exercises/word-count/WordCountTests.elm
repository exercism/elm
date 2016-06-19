module Main exposing (..)

import ElmTest exposing (..)
import Dict exposing (Dict)
import WordCount exposing (wordCount)


tests : Test
tests =
    suite "Word Count"
        [ test "count one word"
            (assertEqual [ ( "word", 1 ) ]
                (wordCount "word" |> Dict.toList)
            )
        , test "count one of each word"
            (assertEqual [ ( "each", 1 ), ( "of", 1 ), ( "one", 1 ) ]
                (wordCount "one of each" |> Dict.toList)
            )
        , test "multiple occurrences of a word"
            (assertEqual [ ( "blue", 1 ), ( "fish", 4 ), ( "one", 1 ), ( "red", 1 ), ( "two", 1 ) ]
                (wordCount "one fish two fish red fish blue fish" |> Dict.toList)
            )
        , test "ignore punctuation"
            (assertEqual [ ( "as", 1 ), ( "car", 1 ), ( "carpet", 1 ), ( "java", 1 ), ( "javascript", 1 ) ]
                (wordCount "car : carpet as java : javascript!!&@$%^&" |> Dict.toList)
            )
        , test "include numbers"
            (assertEqual [ ( "1", 1 ), ( "2", 1 ), ( "testing", 2 ) ]
                (wordCount "testing, 1, 2 testing" |> Dict.toList)
            )
        , test "normalize case"
            (assertEqual [ ( "go", 3 ), ( "stop", 2 ) ]
                (wordCount "go Go GO Stop stop" |> Dict.toList)
            )
        ]


main : Program Never
main =
    runSuite tests
