module Tests exposing (tests)

import Expect
import ResistorColor
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "ResistorColor"
        [ describe "Color codes"
            [ test "Black" <|
                \() ->
                    ResistorColor.colorCode "black"
                        |> Expect.equal 0
            , skip <|
                test "White" <|
                    \() ->
                        ResistorColor.colorCode "white"
                            |> Expect.equal 9
            , skip <|
                test "Orange" <|
                    \() ->
                        ResistorColor.colorCode "orange"
                            |> Expect.equal 3
            ]
        , skip <|
            test "Colors" <|
                \() ->
                    ResistorColor.colors
                        |> Expect.equal [ "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" ]
        ]
