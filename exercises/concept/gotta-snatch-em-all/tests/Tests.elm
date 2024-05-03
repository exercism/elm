module Tests exposing (tests)

import Expect
import GottaSnatchEmAll
import Set
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "GottaSnatchEmAll"
        [ describe "1"
            [ test "newCollection creates a singleton" <|
                \() ->
                    GottaSnatchEmAll.newCollection "Bleakachu"
                        |> Expect.equalSets (Set.singleton "Bleakachu")
            , test "newCollection creates another singleton" <|
                \() ->
                    GottaSnatchEmAll.newCollection "Shiny Bleakachu"
                        |> Expect.equalSets (Set.singleton "Shiny Bleakachu")
            ]
        , describe "2"
            [ test "addCard to an empty collection" <|
                \() ->
                    GottaSnatchEmAll.addCard "Veevee" Set.empty
                        |> Expect.equal ( False, Set.singleton "Veevee" )
            , test "addCard to a collection that doesn't have the card" <|
                \() ->
                    GottaSnatchEmAll.addCard "Veevee" (Set.singleton "Bleakachu")
                        |> Expect.equal ( False, Set.fromList [ "Bleakachu", "Veevee" ] )
            , test "addCard to a collection that already has the card" <|
                \() ->
                    GottaSnatchEmAll.addCard "Veevee" (Set.singleton "Veevee")
                        |> Expect.equal ( True, Set.singleton "Veevee" )
            , test "addCard to larger collection that already has the card" <|
                \() ->
                    GottaSnatchEmAll.addCard "Veevee" (Set.fromList [ "Bleakachu", "Veevee" ])
                        |> Expect.equal ( True, Set.fromList [ "Bleakachu", "Veevee" ] )
            ]
        , describe "3"
            [ test "tradeCard to an empty collection" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" Set.empty
                        |> Expect.equal ( False, Set.singleton "Gyros" )
            , test "tradeCard, trading a card I don't have for a card I don't have" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" (Set.singleton "Bleakachu")
                        |> Expect.equal ( False, Set.fromList [ "Bleakachu", "Gyros" ] )
            , test "tradeCard, trading a card I don't have for a card I have" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" (Set.singleton "Gyros")
                        |> Expect.equal ( False, Set.singleton "Gyros" )
            , test "tradeCard, trading a card I have for a card I have" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" (Set.fromList [ "Charilord", "Gyros" ])
                        |> Expect.equal ( False, Set.singleton "Gyros" )
            , test "tradeCard, trading a card I have for a card I don't have" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" (Set.singleton "Charilord")
                        |> Expect.equal ( True, Set.singleton "Gyros" )
            , test "tradeCard, trading a card I have for a card I don't have in a larger collection" <|
                \() ->
                    GottaSnatchEmAll.tradeCard "Charilord" "Gyros" (Set.fromList [ "Charilord", "Bleakachu", "Veevee" ])
                        |> Expect.equal ( True, Set.fromList [ "Gyros", "Bleakachu", "Veevee" ] )
            ]
        , describe "4"
            [ test "removeDuplicates of an empty list" <|
                \() ->
                    GottaSnatchEmAll.removeDuplicates []
                        |> Expect.equalLists []
            , test "removeDuplicates of a singleton list" <|
                \() ->
                    GottaSnatchEmAll.removeDuplicates [ "Wigglycream" ]
                        |> Expect.equalLists [ "Wigglycream" ]
            , test "removeDuplicates of a list with the same card many times over" <|
                \() ->
                    GottaSnatchEmAll.removeDuplicates [ "Wigglycream", "Wigglycream", "Wigglycream" ]
                        |> Expect.equalLists [ "Wigglycream" ]
            , test "removeDuplicates of a list with many cards" <|
                \() ->
                    GottaSnatchEmAll.removeDuplicates [ "Quarterpie", "Wigglycream", "Cooltentbrov", "Mayofried", "Wigglycream", "Cooltentbrov", "Cooltentbrov" ]
                        |> Expect.equalLists [ "Cooltentbrov", "Mayofried", "Quarterpie", "Wigglycream" ]
            ]
        , describe "5"
            [ test "extraCards of empty collections" <|
                \() ->
                    GottaSnatchEmAll.extraCards Set.empty Set.empty
                        |> Expect.equal 0
            , test "extraCards of singleton vs empty collection" <|
                \() ->
                    GottaSnatchEmAll.extraCards (Set.singleton "Shazam") Set.empty
                        |> Expect.equal 1
            , test "extraCards of empty collection vs singleton" <|
                \() ->
                    GottaSnatchEmAll.extraCards Set.empty (Set.singleton "Shazam")
                        |> Expect.equal 0
            , test "extraCards of same collection" <|
                \() ->
                    GottaSnatchEmAll.extraCards
                        (Set.fromList [ "Shazam", "Wigglycream" ])
                        (Set.fromList [ "Shazam", "Wigglycream" ])
                        |> Expect.equal 0
            , test "extraCards of two different collections" <|
                \() ->
                    GottaSnatchEmAll.extraCards
                        (Set.fromList [ "Shazam", "Cooltentbro", "Wigglycream" ])
                        (Set.fromList [ "Gyros", "Wigglycream" ])
                        |> Expect.equal 2
            , test "extraCards of reversed collections" <|
                \() ->
                    GottaSnatchEmAll.extraCards
                        (Set.fromList [ "Gyros", "Wigglycream" ])
                        (Set.fromList [ "Shazam", "Cooltentbro", "Wigglycream" ])
                        |> Expect.equal 1
            ]
        , describe "6"
            [ test "boringCards of no collection" <|
                \() ->
                    GottaSnatchEmAll.boringCards []
                        |> Expect.equalLists []
            , test "boringCards of empty collections" <|
                \() ->
                    GottaSnatchEmAll.boringCards [ Set.empty, Set.empty ]
                        |> Expect.equalLists []
            , test "boringCards of singleton and empty collection" <|
                \() ->
                    GottaSnatchEmAll.boringCards [ Set.singleton "Shazam", Set.empty ]
                        |> Expect.equalLists []
            , test "boringCards of identical collections" <|
                \() ->
                    GottaSnatchEmAll.boringCards
                        [ Set.fromList [ "Shazam", "Wigglycream" ]
                        , Set.fromList [ "Shazam", "Wigglycream" ]
                        ]
                        |> Expect.equalLists [ "Shazam", "Wigglycream" ]
            , test "boringCards of collections with no overlap" <|
                \() ->
                    GottaSnatchEmAll.boringCards
                        [ Set.fromList [ "Gyros", "Wigglycream", "Veevee" ]
                        , Set.fromList [ "Bleakachu", "Veevee" ]
                        , Set.fromList [ "Shazam", "Gyros", "Cooltentbro", "Wigglycream" ]
                        ]
                        |> Expect.equalLists []
            , test "boringCards of collections with some overlap" <|
                \() ->
                    GottaSnatchEmAll.boringCards
                        [ Set.fromList [ "Gyros", "Wigglycream", "Veevee" ]
                        , Set.fromList [ "Gyros", "Bleakachu", "Veevee" ]
                        , Set.fromList [ "Gyros", "Shazam", "Gyros", "Veevee", "Cooltentbro", "Wigglycream" ]
                        ]
                        |> Expect.equalLists [ "Gyros", "Veevee" ]
            ]
        , describe "7"
            [ test "totalCards of no collection" <|
                \() ->
                    GottaSnatchEmAll.totalCards []
                        |> Expect.equal 0
            , test "totalCards of single collection input" <|
                \() ->
                    GottaSnatchEmAll.totalCards [ Set.fromList [ "Shazam", "Wigglycream" ] ]
                        |> Expect.equal 2
            , test "totalCards of empty collections" <|
                \() ->
                    GottaSnatchEmAll.totalCards [ Set.empty, Set.empty ]
                        |> Expect.equal 0
            , test "totalCards of singleton and empty collection" <|
                \() ->
                    GottaSnatchEmAll.totalCards
                        [ Set.singleton "Shazam"
                        , Set.empty
                        ]
                        |> Expect.equal 1
            , test "totalCards of same collections" <|
                \() ->
                    GottaSnatchEmAll.totalCards
                        [ Set.fromList [ "Shazam", "Wigglycream" ]
                        , Set.fromList [ "Shazam", "Wigglycream" ]
                        ]
                        |> Expect.equal 2
            , test "totalCards of two collections" <|
                \() ->
                    GottaSnatchEmAll.totalCards
                        [ Set.fromList [ "Shazam", "Cooltentbro", "Wigglycream" ]
                        , Set.fromList [ "Gyros", "Wigglycream" ]
                        ]
                        |> Expect.equal 4
            , test "totalCards of three collections" <|
                \() ->
                    GottaSnatchEmAll.totalCards
                        [ Set.fromList [ "Gyros", "Wigglycream", "Veevee" ]
                        , Set.fromList [ "Bleakachu", "Veevee" ]
                        , Set.fromList [ "Shazam", "Gyros", "Cooltentbro", "Wigglycream" ]
                        ]
                        |> Expect.equal 6
            ]
        , describe "8"
            [ test "splitShinyCards of empty collection" <|
                \() ->
                    GottaSnatchEmAll.splitShinyCards Set.empty
                        |> Expect.equal ( [], [] )
            , test "splitShinyCards with one normal card" <|
                \() ->
                    GottaSnatchEmAll.splitShinyCards (Set.singleton "Blasturtle")
                        |> Expect.equal ( [], [ "Blasturtle" ] )
            , test "splitShinyCards with one shiny card" <|
                \() ->
                    GottaSnatchEmAll.splitShinyCards (Set.singleton "Shiny Hitmonchuck")
                        |> Expect.equal ( [ "Shiny Hitmonchuck" ], [] )
            , test "splitShinyCards with many cards" <|
                \() ->
                    GottaSnatchEmAll.splitShinyCards
                        (Set.fromList
                            [ "Shiny Hitmonchuck"
                            , "Blasturtle"
                            , "Shiny Shazam"
                            , "Shiny Phiswan"
                            , "Zumbat"
                            , "Hitmonchuck"
                            ]
                        )
                        |> Expect.equal
                            ( [ "Shiny Hitmonchuck", "Shiny Phiswan", "Shiny Shazam" ]
                            , [ "Blasturtle", "Hitmonchuck", "Zumbat" ]
                            )
            ]
        ]
