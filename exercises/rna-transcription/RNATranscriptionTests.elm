module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import RNATranscription exposing (toRNA)


tests : Test
tests =
  suite
    "RNATranscription"
    [ test
        "complement of cytosine is guanine"
        (assertEqual (Ok "G") (toRNA "C"))
    , test
        "complement of guanine is cytosine"
        (assertEqual (Ok "C") (toRNA "G"))
    , test
        "complement of thymine is adenine"
        (assertEqual (Ok "A") (toRNA "T"))
    , test
        "complement of adenine is uracil"
        (assertEqual (Ok "U") (toRNA "A"))
    , test
        "complement"
        (assertEqual (Ok "UGCACCAGAAUU") (toRNA "ACGTGGTCTTAA"))
    , test
        "correctly handles completely invalid input"
        (assertEqual (Err 'X') (toRNA "XXX"))
    , test
        "correctly handles partially invalid input"
        (assertEqual (Err 'U') (toRNA "UGAAXXXGACAUG"))
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
