module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import SpaceAge exposing (Planet(..), ageOn)


tests : Test
tests =
  suite
    "SpaceAge"
    [ test
        "age in earth years"
        (assertEqual 32 (round (ageOn Earth 1000000000)))
    , test
        "age in mercury years"
        (assertEqual 281 (round (ageOn Mercury 2134835688)))
    , test
        "age in venus years"
        (assertEqual 10 (round (ageOn Venus 189839836)))
    , test
        "age on mars"
        (assertEqual 39 (round (ageOn Mars 2329871239)))
    , test
        "age on jupiter"
        (assertEqual 2 (round (ageOn Jupiter 901876382)))
    , test
        "age on saturn"
        (assertEqual 3 (round (ageOn Saturn 3000000000)))
    , test
        "age on uranus"
        (assertEqual 1 (round (ageOn Uranus 3210123456)))
    , test
        "age on neptune"
        (assertEqual 2 (round (ageOn Neptune 8210123456)))
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
