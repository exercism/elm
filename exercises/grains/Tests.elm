port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Grains exposing (square)


tests : Test
tests =
    describe "Grains"
        [ describe "square"
            [ test "of 1" <|
                \() -> Expect.equal (Just 1) (square 1)
            , test "of 2" <|
                \() -> Expect.equal (Just 2) (square 2)
            , test "of 3" <|
                \() -> Expect.equal (Just 4) (square 3)
            , test "of 4" <|
                \() -> Expect.equal (Just 8) (square 4)
            , test "of 16" <|
                \() -> Expect.equal (Just 32768) (square 16)
            , test "of 32" <|
                \() -> Expect.equal (Just 2147483648) (square 32)
            , test "square 0 raises an exception" <|
                \() -> Expect.equal Nothing (square 0)
            , test "negative square raises an exception" <|
                \() -> Expect.equal Nothing (square -1)
            ]
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
