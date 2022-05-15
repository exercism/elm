module Tests exposing (..)

import Dict
import Expect
import Test exposing (..)
import TopScorers exposing (..)
import TopScorersSupport exposing (..)


tests : Test
tests =
    describe "Top Scorers"
        [ test "formatPlayer should return the player name and the goal count" <|
            \() ->
                formatPlayer "Cedd" (Dict.singleton "Cedd" 3)
                    |> Expect.equal
                        "Cedd: 3"
        ]
