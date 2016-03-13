module Main (..) where

import Task
import Console
import ElmTest exposing (..)
import HelloWorld exposing (helloWorld)


tests : Test
tests =
  suite
    "Hello, World!"
    [ test "Hello with no name" (assertEqual "Hello, World!" (helloWorld Nothing))
    , test "Hello to a sample name" (assertEqual "Hello, Alice!" (helloWorld (Just "Alice")))
    , test "Hello to another sample name" (assertEqual "Hello, Bob!" (helloWorld (Just "Bob")))
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
