module Tests exposing (tests)

import Bandwagoner exposing (..)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "Bandwagoner"
        [ describe "1"
            [ test "has Coach type alias with correct fields in correct order" <|
                \_ ->
                    Coach "Steve Kerr" True
                        |> Expect.equal { name = "Steve Kerr", formerPlayer = True }
            , test "has Stats type alias with correct fields in correct order" <|
                \_ ->
                    Stats 55 27
                        |> Expect.equal { wins = 55, losses = 27 }
            , test "has Team type alias with correct fields in correct order" <|
                \_ ->
                    let
                        coach =
                            Coach "Red Auerbach" False

                        stats =
                            Stats 58 22

                        team =
                            { name = "Boston Celtics", coach = coach, stats = stats }
                    in
                    Expect.equal team (Team "Boston Celtics" coach stats)
            ]
        , describe "2"
            [ test "createTeam creates a Team structural type" <|
                \_ ->
                    let
                        coach =
                            Coach "Red Auerbach" False

                        stats =
                            Stats 58 22

                        team =
                            createTeam "Boston Celtics" stats coach
                    in
                    Expect.equal team (Team "Boston Celtics" coach stats)
            ]
        , describe "3"
            [ test "can replace coach for a team" <|
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
                            replaceCoach newCoach team
                    in
                    Expect.equal newTeam (Team "New York Knicks" newCoach stats)
            ]
        , describe "4"
            [ test "should root for teams that have more wins than losses" <|
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
            , test "should root for extended teams that have more wins than losses" <|
                \_ ->
                    { name = "", coach = Coach "" True, stats = Stats 1 0, someOtherField = "" }
                        |> rootForTeam
                        |> Expect.equal True
            ]
        ]
