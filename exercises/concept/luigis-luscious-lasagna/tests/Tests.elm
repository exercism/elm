module Tests exposing (tests)

import Expect
import LuigisLusciousLasagna exposing (remainingTimeInMinutes)
import Test exposing (..)


tests : Test
tests =
    describe "LuciansLusciousLasagna"
        [ test "For a 3-layers lasagna started 10 minutes ago, there are 36 minutes remaining" <|
            \_ ->
                remainingTimeInMinutes 3 10
                    |> Expect.equal ((3 * 2) + 40 - 10)
        , test "For a 6-layers lasagna started 30 minutes ago, there are 22 minutes remaining" <|
            \_ ->
                remainingTimeInMinutes 6 30
                    |> Expect.equal ((6 * 2) + 40 - 30)
        ]
