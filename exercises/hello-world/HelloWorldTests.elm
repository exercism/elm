module Main exposing (..)

import ElmTest exposing (..)
import HelloWorld exposing (helloWorld)


tests : Test
tests =
    suite "Hello, World!"
        [ test "Hello with no name" (assertEqual "Hello, World!" (helloWorld Nothing))
        , test "Hello to a sample name" (assertEqual "Hello, Alice!" (helloWorld (Just "Alice")))
        , test "Hello to another sample name" (assertEqual "Hello, Bob!" (helloWorld (Just "Bob")))
        ]


main : Program Never
main =
    runSuite tests
