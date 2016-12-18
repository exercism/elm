port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import HelloWorld exposing (helloWorld)


tests : Test
tests =
    describe "Hello, World!"
        [ test "Hello with no name" <|
            \() ->
                Expect.equal "Hello, World!" (helloWorld Nothing)
        , test "Hello to a sample name" <|
            \() ->
                Expect.equal "Hello, Alice!" (helloWorld (Just "Alice"))
        , test "Hello to another sample name" <|
            \() ->
                Expect.equal "Hello, Bob!" (helloWorld (Just "Bob"))
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
