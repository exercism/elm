module Tests exposing (tests)

import BlorkemonCards exposing (..)
import Expect
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "BlorkemonCards"
        [ describe "1"
            [ test "First is more powerful" <|
                \() ->
                    isMorePowerful ( "Bleakachu", 60, False ) ( "Veevee", 40, True )
                        |> Expect.equal True
            , test "Second is more powerful" <|
                \() ->
                    isMorePowerful ( "Bleakachu", 50, True ) ( "Veevee", 70, True )
                        |> Expect.equal False
            , test "Same power" <|
                \() ->
                    isMorePowerful ( "Bleakachu", 55, False ) ( "Veevee", 55, False )
                        |> Expect.equal False
            ]
        , describe "2"
            [ test "First is more powerful" <|
                \() ->
                    maxPower ( "Charilord", 60, True ) ( "Gyros", 40, True )
                        |> Expect.equal 60
            , test "Second is more powerful" <|
                \() ->
                    maxPower ( "Charilord", 50, True ) ( "Gyros", 70, True )
                        |> Expect.equal 70
            , test "Same power" <|
                \() ->
                    maxPower ( "Charilord", 55, False ) ( "Gyros", 55, False )
                        |> Expect.equal 55
            ]
        , describe "3"
            [ test "A bunch of monsters" <|
                \() ->
                    sortByMonsterName
                        [ ( "Wigglycream", 44, True )
                        , ( "Quarterpie", 12, False )
                        , ( "Cooltentbrov", 60, False )
                        , ( "Cooltentbro", 60, False )
                        , ( "Mayofried", 25, False )
                        , ( "Shazam", 65, True )
                        ]
                        |> Expect.equal
                            [ ( "Cooltentbro", 60, False )
                            , ( "Cooltentbrov", 60, False )
                            , ( "Mayofried", 25, False )
                            , ( "Quarterpie", 12, False )
                            , ( "Shazam", 65, True )
                            , ( "Wigglycream", 44, True )
                            ]
            ]
        , describe "4"
            [ test "A bunch of monsters" <|
                \() ->
                    sortByCoolness
                        [ ( "Wigglycream", 44, True )
                        , ( "Quarterpie", 30, False )
                        , ( "Cooltentbro", 60, False )
                        , ( "Mayofried", 25, False )
                        , ( "Shazam", 65, True )
                        ]
                        |> Expect.equal
                            [ ( "Shazam", 65, True )
                            , ( "Wigglycream", 44, True )
                            , ( "Cooltentbro", 60, False )
                            , ( "Quarterpie", 30, False )
                            , ( "Mayofried", 25, False )
                            ]
            ]
        , describe "5"
            [ test "First is more powerful" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 60, True ) ( "Hitmonchuck", 40, True )
                        |> Expect.equal GT
            , test "Second is more powerful" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 50, True ) ( "Hitmonchuck", 70, True )
                        |> Expect.equal LT
            , test "Same power, no shiny" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 55, False ) ( "Hitmonchuck", 55, False )
                        |> Expect.equal EQ
            , test "Same power, both shiny" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 55, True ) ( "Hitmonchuck", 55, True )
                        |> Expect.equal EQ
            , test "Same power, first is shiny" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 55, True ) ( "Hitmonchuck", 55, False )
                        |> Expect.equal GT
            , test "Same power, second is shiny" <|
                \() ->
                    compareShinyPower ( "Blasturtle", 55, False ) ( "Hitmonchuck", 55, True )
                        |> Expect.equal LT
            , test "A bunch of monsters" <|
                \() ->
                    List.sortWith compareShinyPower
                        [ ( "Wigglycream", 50, True )
                        , ( "Quarterpie", 50, False )
                        , ( "Cooltentbro", 45, False )
                        , ( "Mayofried", 55, False )
                        , ( "Shazam", 50, True )
                        ]
                        |> Expect.equal
                            [ ( "Cooltentbro", 45, False )
                            , ( "Quarterpie", 50, False )
                            , ( "Wigglycream", 50, True )
                            , ( "Shazam", 50, True )
                            , ( "Mayofried", 55, False )
                            ]
            ]
        , describe "6"
            [ test "First is more powerful" <|
                \() ->
                    expectedWinner ( "Phiswan", 60, True ) ( "Zumbat", 40, True )
                        |> Expect.equal "Phiswan"
            , test "Second is more powerful" <|
                \() ->
                    expectedWinner ( "Phiswan", 50, True ) ( "Zumbat", 70, True )
                        |> Expect.equal "Zumbat"
            , test "Same power, no shiny" <|
                \() ->
                    expectedWinner ( "Phiswan", 55, False ) ( "Zumbat", 55, False )
                        |> Expect.equal "too close to call"
            , test "Same power, both shiny" <|
                \() ->
                    expectedWinner ( "Phiswan", 55, True ) ( "Zumbat", 55, True )
                        |> Expect.equal "too close to call"
            , test "Same power, first is shiny" <|
                \() ->
                    expectedWinner ( "Phiswan", 55, True ) ( "Zumbat", 55, False )
                        |> Expect.equal "Phiswan"
            , test "Same power, second is shiny" <|
                \() ->
                    expectedWinner ( "Phiswan", 55, False ) ( "Zumbat", 55, True )
                        |> Expect.equal "Zumbat"
            ]
        ]
