module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import Strain exposing (keep, discard)
import String


even : Int -> Bool
even number =
  number % 2 == 0


odd : Int -> Bool
odd number =
  number % 2 == 1


isFirstLetter : String -> String -> Bool
isFirstLetter letter word =
  (String.left 1 word) == letter


lessThanTen : number -> Bool
lessThanTen num =
  num < 10


tests : Test
tests =
  suite
    "Strain"
    [ test
        "empty keep"
        (assertEqual
          []
          (keep lessThanTen [])
        )
    , test
        "keep everything"
        (assertEqual
          [ 1, 2, 3 ]
          (keep lessThanTen [ 1, 2, 3 ])
        )
    , test
        "keep first and last"
        (assertEqual
          [ 1, 3 ]
          (keep odd [ 1, 2, 3 ])
        )
    , test
        "keep nothing"
        (assertEqual
          []
          (keep even [ 1, 3, 5, 7 ])
        )
    , test
        "keep neither first nor last"
        (assertEqual
          [ 2 ]
          (keep even [ 1, 2, 3 ])
        )
    , test
        "keep strings"
        (assertEqual
          [ "zebra", "zombies", "zealot" ]
          (keep (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        )
    , test
        "empty discard"
        (assertEqual
          []
          (discard lessThanTen [])
        )
    , test
        "discard everything"
        (assertEqual
          []
          (discard lessThanTen [ 1, 2, 3 ])
        )
    , test
        "discard first and last"
        (assertEqual
          [ 2 ]
          (discard odd [ 1, 2, 3 ])
        )
    , test
        "discard nothing"
        (assertEqual
          [ 1, 3, 5, 7 ]
          (discard even [ 1, 3, 5, 7 ])
        )
    , test
        "discard neither first nor last"
        (assertEqual
          [ 1, 3 ]
          (discard even [ 1, 2, 3 ])
        )
    , test
        "discard strings"
        (assertEqual
          [ "apple", "banana", "cherimoya" ]
          (discard (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
