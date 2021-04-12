module Tests exposing (tests)

import Expect
import Fuzz
import LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)
import Test exposing (..)


tests : Test
tests =
    describe "LuciansLusciousLasagna"
        [ test "expectedMinutesInOven" <|
            \_ ->
                expectedMinutesInOven
                    |> Expect.equal 40
        , fuzz positiveInt "preparationTimeInMinutes" <|
            \layers ->
                preparationTimeInMinutes layers
                    |> Expect.equal (2 * layers)
        , fuzz (Fuzz.tuple ( positiveInt, positiveInt )) "elapsedTimeInMinutes" <|
            \( layers, passedAlready ) ->
                elapsedTimeInMinutes layers passedAlready
                    |> Expect.equal (2 * layers + passedAlready)
        ]


positiveInt =
    Fuzz.intRange 0 1000000
