module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import Pangram exposing (isPangram)


tests : Test
tests =
  suite
    "Pangram"
    [ test
        "sentence empty"
        (assertEqual
          False
          (isPangram "")
        )
    , test
        "pangram with only lower case"
        (assertEqual
          True
          (isPangram "the quick brown fox jumps over the lazy dog")
        )
    , test
        "missing character 'x'"
        (assertEqual
          False
          (isPangram "a quick movement of the enemy will jeopardize five gunboats")
        )
    , test
        "pangram with mixed case and punctuation"
        (assertEqual
          True
          (isPangram "\"Five quacking Zephyrs jolt my wax bed.\"")
        )
    , test
        "pangram with non ascii characters"
        (assertEqual
          True
          (isPangram "Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
        )
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
