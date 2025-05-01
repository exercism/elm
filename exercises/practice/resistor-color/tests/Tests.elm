module Tests exposing (tests)

import Expect
import ResistorColor exposing (Color(..), colorCode, colors)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "ResistorColor"
        [ describe "Color codes"
            [ test "Black" <|
                \() ->
                    ResistorColor.colorCode Black
                        |> Expect.equal 0
            , skip <|
                test "White" <|
                    \() ->
                        ResistorColor.colorCode White
                            |> Expect.equal 9
            , skip <|
                test "Orange" <|
                    \() ->
                        ResistorColor.colorCode Orange
                            |> Expect.equal 3
            ]
        , skip <|
            test "Colors" <|
                \() ->
                    ResistorColor.colors
                        |> Expect.equal [ Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White ]
        ]
