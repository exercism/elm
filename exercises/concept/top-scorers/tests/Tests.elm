module Tests exposing (..)

import Dict
import Expect
import Test exposing (..)
import TopScorers exposing (..)
import TopScorersSupport exposing (..)


tests : Test
tests =
    describe "Top Scorers"
        [ test "aggregateScores should count the number of occurences of a player name" <|
            \() ->
                aggregateScorers [ "Betty", "Cedd", "Betty" ]
                    |> Expect.equal
                        (Dict.fromList
                            [ ( "Betty", 2 ), ( "Cedd", 1 ) ]
                        )
        , test "removeInsignificantPlayers should remove players that have scored less goals than the threshold" <|
            \() ->
                removeInsignificantPlayers 1
                    (Dict.fromList
                        [ ( "Betty", 2 ), ( "Cedd", 1 ) ]
                    )
                    |> Expect.equal
                        (Dict.fromList
                            [ ( "Betty", 2 ) ]
                        )
        , test "resetPlayerGoalCount should set the goalCount to zero for the player" <|
            \() ->
                resetPlayerGoalCount "Betty"
                    (Dict.fromList
                        [ ( "Betty", 2 ), ( "Cedd", 1 ) ]
                    )
                    |> Expect.equal
                        (Dict.fromList
                            [ ( "Betty", 0 ), ( "Cedd", 1 ) ]
                        )
        , test "formatPlayer should return the player name and the goal count" <|
            \() ->
                formatPlayer "Betty" (Dict.singleton "Betty" 3)
                    |> Expect.equal
                        "Betty: 3"
        , test "formatPlayers should return the player name and the goal count, ordered by player name" <|
            \() ->
                formatPlayers
                    (Dict.fromList
                        [ ( "Cedd", 1 ), ( "Betty", 2 ) ]
                    )
                    |> Expect.equal
                        "Betty: 2, Cedd: 1"
        , test "combineGames should count goals in both games" <|
            \() ->
                combineGames
                    (Dict.fromList
                        [ ( "Cedd", 1 ), ( "Betty", 2 ) ]
                    )
                    (Dict.fromList
                        [ ( "Betty", 2 ), ( "Luigi", 3 ) ]
                    )
                    |> Expect.equal
                        (Dict.fromList
                            [ ( "Betty", 4 ), ( "Cedd", 1 ), ( "Luigi", 3 ) ]
                        )
        ]
