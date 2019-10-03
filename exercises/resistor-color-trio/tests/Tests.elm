module Tests exposing (tests)

import Expect
import ResistorColorTrio exposing (colorsToOhms)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Resistor Color Trio"
        [ test "Orange and orange and black" <|
            \() ->
                Expect.equal (Ok "33 ohms") <|
                    colorsToOhms ( "orange", "orange", "black" )
        , skip <|
            test "Blue and grey and brown" <|
                \() ->
                    Expect.equal (Ok "680 ohms") <|
                        colorsToOhms ( "blue", "grey", "brown" )
        , skip <|
            test "Red and black and red" <|
                \() ->
                    Expect.equal (Ok "2 kiloohms") <|
                        colorsToOhms ( "red", "black", "red" )
        , skip <|
            test "Green and brown and orange" <|
                \() ->
                    Expect.equal (Ok "51 kiloohms") <|
                        colorsToOhms ( "green", "brown", "orange" )
        , skip <|
            test "Yellow and violet and yellow" <|
                \() ->
                    Expect.equal (Ok "470 kiloohms") <|
                        colorsToOhms ( "yellow", "violet", "yellow" )
        ]
