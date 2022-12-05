module Tests exposing (tests)

import Expect
import Result exposing (fromMaybe)
import SecureTreasureChest exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "SecureTreasureChest"
        [ describe "1"
            [ test "SecureTreasureChest is exposed" <|
                \_ ->
                    let
                        identity : SecureTreasureChest a -> SecureTreasureChest a
                        identity secureTreasureChest =
                            secureTreasureChest
                    in
                    Expect.pass
            ]
        , describe "2"
            [ test "Treasure can be a string" <|
                \_ ->
                    createTreasure "password" "treasure"
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createTreasure "password" "treasure")
                            ]
            , test "Treasure can be an int" <|
                \_ ->
                    createTreasure "password" 5
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createTreasure "password" 5)
                            ]
            ]
        , describe "3"
            [ test "The treasure is returned if the correct password is used" <|
                \_ ->
                    createTreasure "password" "treasure"
                        |> Maybe.andThen (getTreasure "password")
                        |> Expect.equal (Just "treasure")
            , test "Nothing is returned if password does not match" <|
                \_ ->
                    createTreasure "password" "treasure"
                        |> Maybe.andThen (getTreasure "wrong-password")
                        |> Expect.equal Nothing
            ]
        , describe "4"
            [ test "createTreasure returns a SecureTreasureChest when password meets minimum length" <|
                \_ ->
                    createTreasure "12345678" "treasure"
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createTreasure "12345678" "treasure")
                            ]
            , test "createTreasure returns Nothing when password is too short" <|
                \_ ->
                    createTreasure "1234567" "treasure"
                        |> Expect.equal Nothing
            ]
        ]
