module Tests exposing (tests)

import Expect
import Test exposing (..)
import TreasureChest exposing (..)


tests : Test
tests =
    describe "TreasureChest"
        [ describe "1"
            [ test "Treasure can be a string" <|
                \_ ->
                    TreasureChest "password" "treasure"
                        |> Expect.equal (TreasureChest "password" "treasure")
            , test "Treasure can be an int" <|
                \_ ->
                    TreasureChest "password" 5
                        |> Expect.equal (TreasureChest "password" 5)
            ]
        , describe "2"
            [ test "The treasure is returned if the correct password is used" <|
                \_ ->
                    TreasureChest "password" "treasure"
                        |> getTreasure "password"
                        |> Expect.equal (Just "treasure")
            , test "Nothing is returned if the correct password is used" <|
                \_ ->
                    TreasureChest "password" "treasure"
                        |> getTreasure "wrong-password"
                        |> Expect.equal Nothing
            ]
        ]
