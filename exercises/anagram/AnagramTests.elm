module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import Anagram exposing (detect)


tests : Test
tests =
  suite
    "Anagram"
    [ test
        "no matches"
        (assertEqual
          []
          (detect "diaper" [ "hello", "world", "zombies", "pants" ])
        )
    , test
        "detects simple anagram"
        (assertEqual
          [ "tan" ]
          (detect "ant" [ "tan", "stand", "at" ])
        )
    , test
        "does not detect false positives"
        (assertEqual
          []
          (detect "galea" [ "eagle" ])
        )
    , test
        "detects multiple anagrams"
        (assertEqual
          [ "stream", "maters" ]
          (detect "master" [ "stream", "pigeon", "maters" ])
        )
    , test
        "does not detect anagram subsets"
        (assertEqual
          []
          (detect "good" [ "dog", "goody" ])
        )
    , test
        "detects anagram"
        (assertEqual
          [ "inlets" ]
          (detect "listen" [ "enlists", "google", "inlets", "banana" ])
        )
    , test
        "detects multiple anagrams"
        (assertEqual
          [ "gallery", "regally", "largely" ]
          (detect "allergy" [ "gallery", "ballerina", "regally", "clergy", "largely", "leading" ])
        )
    , test
        "does not detect indentical words"
        (assertEqual
          [ "cron" ]
          (detect "corn" [ "corn", "dark", "Corn", "rank", "CORN", "cron", "park" ])
        )
    , test
        "does not detect non-anagrams with identical checksum"
        (assertEqual
          []
          (detect "mass" [ "last" ])
        )
    , test
        "detects anagrams case-insensitively"
        (assertEqual
          [ "Carthorse" ]
          (detect "Orchestra" [ "cashregister", "Carthorse", "radishes" ])
        )
    , test
        "detects anagrams using case-insensitive subject"
        (assertEqual
          [ "carthorse" ]
          (detect "Orchestra" [ "cashregister", "carthorse", "radishes" ])
        )
    , test
        "detects anagrams using case-insensitve possible matches"
        (assertEqual
          [ "Carthorse" ]
          (detect "orchestra" [ "cashregister", "Carthorse", "radishes" ])
        )
    , test
        "does not detect a word as its own anagram"
        (assertEqual
          []
          (detect "banana" [ "Banana" ])
        )
    , test
        "does not detect a anagram if the original word is repeated"
        (assertEqual
          []
          (detect "go" [ "go Go GO" ])
        )
    , test
        "anagrams must use all letters exactly once"
        (assertEqual
          []
          (detect "tapper" [ "patter" ])
        )
    , test
        "eliminates anagrams with the same checksum"
        (assertEqual
          []
          (detect "mass" [ "last" ])
        )
    , test
        "detects unicode anagrams"
        (assertEqual
          [ "ΒΓΑ", "γβα" ]
          (detect "ΑΒΓ" [ "ΒΓΑ", "ΒΓΔ", "γβα" ])
        )
    , test
        "eliminates misleading unicode anagrams"
        (assertEqual
          []
          (detect "ΑΒΓ" [ "ABΓ" ])
        )
    , test
        "capital word is not own anagram"
        (assertEqual
          []
          (detect "BANANA" [ "Banana" ])
        )
    , test
        "anagrams must use all letters exactly once"
        (assertEqual
          []
          (detect "patter" [ "tapper" ])
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
