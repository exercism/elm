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
                    { name = "Steve Kerr", formerPlayer = True }
                        |> Expect.equal { name = "Steve Kerr", formerPlayer = True }
            , test "has Stats type alias with correct fields in correct order" <|
                \_ ->
                    { wins = 55, losses = 27 }
                        |> Expect.equal { wins = 55, losses = 27 }
            , test "has Team type alias with correct fields in correct order" <|
                \_ ->
                    let
                        coach =
                            { name = "Red Auerbach", formerPlayer = False }

                        stats =
                            { wins = 58, losses = 22 }

                        team =
                            { name = "Boston Celtics", coach = coach, stats = stats }
                    in
                    Expect.equal team { name = "Boston Celtics", coach = coach, stats = stats }
            ]
        , describe "2"
            [ test "createTeam creates a Team structural type" <|
                \_ ->
                    let
                        coach =
                            { name = "Red Auerbach", formerPlayer = False }

                        stats =
                            { wins = 58, losses = 22 }

                        team =
                            createTeam "Boston Celtics" stats coach
                    in
                    Expect.equal team { name = "Boston Celtics", coach = coach, stats = stats }
            ]
        , describe "3"
            [ test "can replace coach for a team" <|
                \_ ->
                    let
                        coach =
                            { name = "Willis Reed", formerPlayer = True }

                        newCoach =
                            { name = "Red Holzman", formerPlayer = True }

                        stats =
                            { wins = 6, losses = 8 }

                        team =
                            { name = "New York Knicks", coach = coach, stats = stats }

                        newTeam =
                            replaceCoach newCoach team
                    in
                    Expect.equal newTeam { name = "New York Knicks", coach = newCoach, stats = stats }
            ]
        , describe "4"
            [ test "should root for teams that have more wins than losses" <|
                \_ ->
                    { name = "", coach = { name = "", formerPlayer = True }, stats = { wins = 1, losses = 0 } }
                        |> rootForTeam
                        |> Expect.equal True
            , test "should not root for teams that lose more than they win" <|
                \_ ->
                    { name = "", coach = { name = "", formerPlayer = True }, stats = { wins = 43, losses = 44 } }
                        |> rootForTeam
                        |> Expect.equal False
            , test "should not root for teams that have equal losses and wins" <|
                \_ ->
                    { name = "", coach = { name = "", formerPlayer = True }, stats = { wins = 143, losses = 143 } }
                        |> rootForTeam
                        |> Expect.equal False
            , test "should root for extended teams that have more wins than losses" <|
                \_ ->
                    { name = "", coach = { name = "", formerPlayer = True }, stats = { wins = 1, losses = 0 }, someOtherField = "" }
                        |> rootForTeam
                        |> Expect.equal True
            ]
        ]
