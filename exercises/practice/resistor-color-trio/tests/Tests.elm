module Tests exposing (tests)

import Expect
import ResistorColorTrio exposing (Color(..), label)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "ResistorColorTrio"
        [ test "Orange and orange and black" <|
            \() ->
                ResistorColorTrio.label [ Orange, Orange, Black ]
                    |> Expect.equal "33 ohms"
        , skip <|
            test "Blue and grey and brown" <|
                \() ->
                    ResistorColorTrio.label [ Blue, Grey, Brown ]
                        |> Expect.equal "680 ohms"
        , skip <|
            test "Red and black and red" <|
                \() ->
                    ResistorColorTrio.label [ Red, Black, Red ]
                        |> Expect.equal "2 kiloohms"
        , skip <|
            test "Green and brown and orange" <|
                \() ->
                    ResistorColorTrio.label [ Green, Brown, Orange ]
                        |> Expect.equal "51 kiloohms"
        , skip <|
            test "Yellow and violet and yellow" <|
                \() ->
                    ResistorColorTrio.label [ Yellow, Violet, Yellow ]
                        |> Expect.equal "470 kiloohms"
        , skip <|
            test "Blue and violet and blue" <|
                \() ->
                    ResistorColorTrio.label [ Blue, Violet, Blue ]
                        |> Expect.equal "67 megaohms"
        , skip <|
            test "Minimum possible value" <|
                \() ->
                    ResistorColorTrio.label [ Black, Black, Black ]
                        |> Expect.equal "0 ohms"
        , skip <|
            test "Maximum possible value" <|
                \() ->
                    ResistorColorTrio.label [ White, White, White ]
                        |> Expect.equal "99 gigaohms"
        , skip <|
            test "First two colors make an invalid octal number" <|
                \() ->
                    ResistorColorTrio.label [ Black, Grey, Black ]
                        |> Expect.equal "8 ohms"
        , skip <|
            test "Ignore extra colors" <|
                \() ->
                    ResistorColorTrio.label [ Blue, Green, Yellow, Orange ]
                        |> Expect.equal "650 kiloohms"
        ]
