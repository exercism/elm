module Tests exposing (tests)

import Expect
import LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)
import Test exposing (..)


tests : Test
tests =
    describe "LuciansLusciousLasagna"
        [ describe "1"
            [ test "The expected amount of time in the oven is 40 minutes" <|
                \_ ->
                    expectedMinutesInOven
                        |> Expect.equal 40
            ]
        , describe "2"
            [ test "For 2 layers, the preparation time is 4 minutes" <|
                \_ ->
                    preparationTimeInMinutes 2
                        |> Expect.equal 4
            , test "For 5 layers, the preparation time is 10 minutes" <|
                \_ ->
                    preparationTimeInMinutes 5
                        |> Expect.equal 10
            ]
        , describe "3"
            [ test "For a 3-layers lasagna already in the oven for 10 minutes, you've spent 16 minutes cooking" <|
                \_ ->
                    elapsedTimeInMinutes 3 10
                        |> Expect.equal 16
            , test "For a 6-layers lasagna already in the oven for 30 minutes, you've spent 42 minutes cooking" <|
                \_ ->
                    elapsedTimeInMinutes 6 30
                        |> Expect.equal 42
            ]
        ]
