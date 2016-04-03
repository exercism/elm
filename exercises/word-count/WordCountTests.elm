module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import Dict exposing (Dict)
import WordCount exposing (wordCount)


tests : Test
tests =
  suite
    "Word Count"
    [ test
        "count one word"
        (assertEqual
          (Dict.fromList [ ( "word", 1 ) ])
          (wordCount "word")
        )
    , test
        "count one of each word"
        (assertEqual
          (Dict.fromList [ ( "one", 1 ), ( "of", 1 ), ( "each", 1 ) ])
          (wordCount "one of each")
        )
    , test
        "multiple occurrences of a word"
        (assertEqual
          (Dict.fromList [ ( "one", 1 ), ( "fish", 4 ), ( "two", 1 ), ( "red", 1 ), ( "blue", 1 ) ])
          (wordCount "one fish two fish red fish blue fish")
        )
    , test
        "ignore punctuation"
        (assertEqual
          (Dict.fromList [ ( "car", 1 ), ( "carpet", 1 ), ( "as", 1 ), ( "java", 1 ), ( "javascript", 1 ) ])
          (wordCount "car : carpet as java : javascript!!&@$%^&")
        )
    , test
        "include numbers"
        (assertEqual
          (Dict.fromList [ ( "testing", 2 ), ( "1", 1 ), ( "2", 1 ) ])
          (wordCount "testing, 1, 2 testing")
        )
    , test
        "normalize case"
        (assertEqual
          (Dict.fromList [ ( "go", 3 ), ( "stop", 2 ) ])
          (wordCount "go Go GO Stop stop")
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
