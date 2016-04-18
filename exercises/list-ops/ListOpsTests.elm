module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import ListOps exposing (..)


tests : Test
tests =
  suite
    "List Ops"
    [ suite
        "length"
        [ test "empty list" (assertEqual 0 (length []))
        , test "non-empty list" (assertEqual 4 (length [1..4]))
        ]
    , suite
        "reverse"
        [ test "empty list" (assertEqual [] (reverse []))
        , test "non-empty list" (assertEqual [ 4, 3, 2, 1 ] (reverse [1..4]))
        ]
    , suite
        "map"
        [ test "empty list" (assertEqual [] (map ((+) 1) []))
        , test "non-empty list" (assertEqual [2..5] (map ((+) 1) [1..4]))
        ]
    , suite
        "filter"
        [ test "empty list" (assertEqual [] (filter (\_ -> True) []))
        , test
            "non-empty list"
            (assertEqual [ 2, 4 ] (filter (\x -> x % 2 == 0) [1..4]))
        ]
    , suite
        "foldl"
        [ test "empty list" (assertEqual 0 (foldl (+) 0 []))
        , test "non-empty list" (assertEqual 10 (foldl (+) 0 [1..4]))
        ]
    , suite
        "foldr"
        [ test "empty list" (assertEqual 0 (foldr (+) 0 []))
        , test "non-empty list" (assertEqual 10 (foldr (+) 0 [1..4]))
        ]
    , suite
        "append"
        [ test "empty lists" (assertEqual [] (append [] []))
        , test
            "empty and non-empty lists"
            (assertEqual [1..4] (append [] [1..4]))
        , test
            "non-empty and empty lists"
            (assertEqual [1..4] (append [1..4] []))
        , test "non-empty lists" (assertEqual [1..8] (append [1..4] [5..8]))
        ]
    , suite
        "concat"
        [ test "empty list" (assertEqual [] (concat []))
        , test
            "list of lists"
            (assertEqual [1..10] (concat [ [1..3], [], [4..7], [8..10] ]))
        ]
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
