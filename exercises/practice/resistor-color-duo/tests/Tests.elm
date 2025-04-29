module Tests exposing (tests)

import Expect
import ResistorColorDuo
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "ResistorColorDuo"
        [ test "Brown and black" <|
            \() ->
                ResistorColorDuo.value [ "brown", "black" ]
                    |> Expect.equal 10
        , skip <|
            test "Blue and grey" <|
                \() ->
                    ResistorColorDuo.value [ "blue", "grey" ]
                        |> Expect.equal 68
        , skip <|
            test "Yellow and violet" <|
                \() ->
                    ResistorColorDuo.value [ "yellow", "violet" ]
                        |> Expect.equal 47
        , skip <|
            test "White and red" <|
                \() ->
                    ResistorColorDuo.value [ "white", "red" ]
                        |> Expect.equal 92
        , skip <|
            test "Orange and orange" <|
                \() ->
                    ResistorColorDuo.value [ "orange", "orange" ]
                        |> Expect.equal 33
        , skip <|
            test "Ignore additional colors" <|
                \() ->
                    ResistorColorDuo.value [ "green", "brown", "orange" ]
                        |> Expect.equal 51
        , skip <|
            test "Black and brown, one-digit" <|
                \() ->
                    ResistorColorDuo.value [ "black", "brown" ]
                        |> Expect.equal 1
        ]
