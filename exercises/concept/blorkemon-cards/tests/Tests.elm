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
                    isMorePowerful (Card "Bleakachu" 60 False) (Card "Veevee" 40 True)
                        |> Expect.equal True
            , test "Second is more powerful" <|
                \() ->
                    isMorePowerful (Card "Bleakachu" 50 True) (Card "Veevee" 70 True)
                        |> Expect.equal False
            , test "Same power" <|
                \() ->
                    isMorePowerful (Card "Bleakachu" 55 False) (Card "Veevee" 55 False)
                        |> Expect.equal False
            ]
        , describe "2"
            [ test "First is more powerful" <|
                \() ->
                    maxPower (Card "Charilord" 60 True) (Card "Gyros" 40 True)
                        |> Expect.equal 60
            , test "Second is more powerful" <|
                \() ->
                    maxPower (Card "Charilord" 50 True) (Card "Gyros" 70 True)
                        |> Expect.equal 70
            , test "Same power" <|
                \() ->
                    maxPower (Card "Charilord" 55 False) (Card "Gyros" 55 False)
                        |> Expect.equal 55
            ]
        , describe "3"
            [ test "A bunch of monsters" <|
                \() ->
                    sortByMonsterName
                        [ Card "Wigglycream" 44 True
                        , Card "Quarterpie" 12 False
                        , Card "Cooltentbrov" 60 False
                        , Card "Cooltentbro" 60 False
                        , Card "Mayofried" 25 False
                        , Card "Shazam" 65 True
                        ]
                        |> Expect.equal
                            [ Card "Cooltentbro" 60 False
                            , Card "Cooltentbrov" 60 False
                            , Card "Mayofried" 25 False
                            , Card "Quarterpie" 12 False
                            , Card "Shazam" 65 True
                            , Card "Wigglycream" 44 True
                            ]
            ]
        , describe "4"
            [ test "A bunch of monsters" <|
                \() ->
                    sortByCoolness
                        [ Card "Wigglycream" 44 True
                        , Card "Quarterpie" 30 False
                        , Card "Cooltentbro" 60 False
                        , Card "Mayofried" 25 False
                        , Card "Shazam" 65 True
                        ]
                        |> Expect.equal
                            [ Card "Shazam" 65 True
                            , Card "Wigglycream" 44 True
                            , Card "Cooltentbro" 60 False
                            , Card "Quarterpie" 30 False
                            , Card "Mayofried" 25 False
                            ]
            ]
        , describe "5"
            [ test "First is more powerful" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 60 True) (Card "Hitmonchuck" 40 True)
                        |> Expect.equal GT
            , test "Second is more powerful" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 50 True) (Card "Hitmonchuck" 70 True)
                        |> Expect.equal LT
            , test "Same power, no shiny" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 55 False) (Card "Hitmonchuck" 55 False)
                        |> Expect.equal EQ
            , test "Same power, both shiny" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 55 True) (Card "Hitmonchuck" 55 True)
                        |> Expect.equal EQ
            , test "Same power, first is shiny" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 55 True) (Card "Hitmonchuck" 55 False)
                        |> Expect.equal GT
            , test "Same power, second is shiny" <|
                \() ->
                    compareShinyPower (Card "Blasturtle" 55 False) (Card "Hitmonchuck" 55 True)
                        |> Expect.equal LT
            , test "A bunch of monsters" <|
                \() ->
                    List.sortWith compareShinyPower
                        [ Card "Wigglycream" 50 True
                        , Card "Quarterpie" 50 False
                        , Card "Cooltentbro" 45 False
                        , Card "Mayofried" 55 False
                        , Card "Shazam" 50 True
                        ]
                        |> Expect.equal
                            [ Card "Cooltentbro" 45 False
                            , Card "Quarterpie" 50 False
                            , Card "Wigglycream" 50 True
                            , Card "Shazam" 50 True
                            , Card "Mayofried" 55 False
                            ]
            ]
        , describe "6"
            [ test "First is more powerful" <|
                \() ->
                    expectedWinner (Card "Phiswan" 60 True) (Card "Zumbat" 40 True)
                        |> Expect.equal "Phiswan"
            , test "Second is more powerful" <|
                \() ->
                    expectedWinner (Card "Phiswan" 50 True) (Card "Zumbat" 70 True)
                        |> Expect.equal "Zumbat"
            , test "Same power, no shiny" <|
                \() ->
                    expectedWinner (Card "Phiswan" 55 False) (Card "Zumbat" 55 False)
                        |> Expect.equal "too close to call"
            , test "Same power, both shiny" <|
                \() ->
                    expectedWinner (Card "Phiswan" 55 True) (Card "Zumbat" 55 True)
                        |> Expect.equal "too close to call"
            , test "Same power, first is shiny" <|
                \() ->
                    expectedWinner (Card "Phiswan" 55 True) (Card "Zumbat" 55 False)
                        |> Expect.equal "Phiswan"
            , test "Same power, second is shiny" <|
                \() ->
                    expectedWinner (Card "Phiswan" 55 False) (Card "Zumbat" 55 True)
                        |> Expect.equal "Zumbat"
            ]
        ]
