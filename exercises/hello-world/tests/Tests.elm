module Tests exposing (tests)

import Expect
import HelloWorld exposing (helloWorld)
import Test exposing (..)


tests : Test
tests =
    test "Hello, World!" <|
        \() ->
            Expect.equal "Hello, World!" helloWorld
