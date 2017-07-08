module Tests exposing (..)

import Test exposing (..)
import Expect
import HelloWorld exposing (helloWorld)


tests : Test
tests =
    describe "Hello, World!"
        [ test "Hello with no name" <|
            \() ->
                Expect.equal "Hello, World!" (helloWorld Nothing)

        -- Once you get the first test passing, remove the
        -- `skip <|` (just leave the comma) on the next two
        -- lines to continue!
        , skip <|
            test "Hello to a sample name" <|
                \() ->
                    Expect.equal "Hello, Alice!" (helloWorld (Just "Alice"))
        , skip <|
            test "Hello to another sample name" <|
                \() ->
                    Expect.equal "Hello, Bob!" (helloWorld (Just "Bob"))
        ]
