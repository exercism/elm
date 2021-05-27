module Tests exposing (tests)

import Bandwagoner exposing (..)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "Bandwagoner"
        [ test "has Coach type alias" <|
            \_ ->
                Coach "Steve Kerr" True
                    |> Expect.equal (Coach "Steve Kerr" True)
        , test "has Stats type alias" <|
            \_ ->
                Stats 55 27
                    |> Expect.equal (Stats 55 27)
        , test "has Team type alias" <|
            \_ ->
                let
                    coach =
                        Coach "Red Auerbach" False

                    stats =
                        Stats 58 22

                    team =
                        Team "Boston Celtics" coach stats
                in
                Expect.equal team (Team "Boston Celtics" coach stats)
        , test "can replace coach for a team" <|
            \_ ->
                let
                    coach =
                        Coach "Willis Reed" True

                    newCoach =
                        Coach "Red Holzman" True

                    stats =
                        Stats 6 8

                    team =
                        Team "New York Knicks" coach stats

                    newTeam =
                        replaceCoach team newCoach
                in
                Expect.equal newTeam (Team "New York Knicks" newCoach stats)
        , test "isSameTeam is true for identical teams" <|
            \_ ->
                let
                    coach =
                        Coach "Pat Riley" True

                    stats =
                        Stats 57 25

                    team =
                        Team "Los Angeles Lakers" coach stats
                in
                isSameTeam team team
                    |> Expect.equal True
        , test "isSameTeam is false for different teams" <|
            \_ ->
                let
                    coach =
                        Coach "Pat Riley" True

                    stats =
                        Stats 57 25

                    team =
                        Team "Los Angeles Lakers" coach stats

                    newStats =
                        Stats 62 20

                    teamWithDifferentStats =
                        Team "Los Angeles Lakers" coach newStats
                in
                isSameTeam team teamWithDifferentStats
                    |> Expect.equal False
        , test "should root for teams that have more wins than losses" <|
            \_ ->
                Team "" (Coach "" True) (Stats 1 0)
                    |> rootForTeam
                    |> Expect.equal True
        , test "should not root for teams that lose more than they win" <|
            \_ ->
                Team "" (Coach "" True) (Stats 43 44)
                    |> rootForTeam
                    |> Expect.equal False
        , test "should not root for teams that have equal losses and wins" <|
            \_ ->
                Team "" (Coach "" True) (Stats 143 143)
                    |> rootForTeam
                    |> Expect.equal False
        ]
