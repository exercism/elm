import String
import Task

import Console
import ElmTest exposing (..)
import HelloWorld exposing (..)


tests : Test
tests =
  suite "Hello, World!"
    [ test "Hello with no name" (assertEqual "Hello, World!" (helloworld Nothing))
    , test "Hello to a sample name" (assertEqual "Hello, Alice!" (helloworld (Just "Alice")))
    , test "Hello to another sample name" (assertEqual "Hello, Bob!" (helloworld (Just "Bob")))
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
