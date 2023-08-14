module Tests exposing (tests)

import Array
import Expect
import MagicianInTraining exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "MagicianInTraining"
        [ describe "1"
            [ test "getCard should return the card at index" <|
                \_ ->
                    getCard 2 (Array.fromList [ 1, 2, 4 ])
                        |> Expect.equal
                            (Just 4)
            ]
        , describe "2"
            [ test "setCard should change the card at index" <|
                \_ ->
                    setCard 2 6 (Array.fromList [ 1, 2, 4 ])
                        |> Expect.equal
                            (Array.fromList [ 1, 2, 6 ])
            , test "setCard should do nothing if the index is out of bounds" <|
                \_ ->
                    setCard 3 6 (Array.fromList [ 1, 2, 4 ])
                        |> Expect.equal
                            (Array.fromList [ 1, 2, 4 ])
            ]
        , describe "3"
            [ test "addCard should add a card" <|
                \_ ->
                    addCard 8 (Array.fromList [ 5, 9, 7, 1 ])
                        |> Expect.equal
                            (Array.fromList [ 5, 9, 7, 1, 8 ])
            ]
        , describe "4"
            [ test "removeCard should remove the card at index" <|
                \_ ->
                    removeCard 2 (Array.fromList [ 3, 2, 6, 4, 8 ])
                        |> Expect.equal
                            (Array.fromList [ 3, 2, 4, 8 ])
            , test "removeCard should do nothing if the index is out of bounds" <|
                \_ ->
                    removeCard 2 (Array.fromList [ 3, 2 ])
                        |> Expect.equal
                            (Array.fromList [ 3, 2 ])
            ]
        , describe "5"
            [ test "evenCardCount returns the number of even cards in the deck" <|
                \_ ->
                    evenCardCount (Array.fromList [ 3, 8, 4, 5, 1, 6, 10 ])
                        |> Expect.equal
                            4
            ]
        ]
