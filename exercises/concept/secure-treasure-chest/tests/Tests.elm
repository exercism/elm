module Tests exposing (tests)

import Expect
import SecureTreasureChest exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "SecureTreasureChest"
        [ describe "1"
            [ test "Password is exposed" <|
                \_ ->
                    let
                        identity : Password -> Password
                        identity password =
                            password
                    in
                    Expect.pass
            , test "createPassword returns a Just Password when password meets minimum length" <|
                \_ ->
                    createPassword "12345678"
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createPassword "12345678")
                            ]
            , test "createPassword returns Nothing when password is too short" <|
                \_ ->
                    createPassword "1234567"
                        |> Expect.equal Nothing
            ]
        , describe "2"
            [ test "SecureTreasureChest is exposed" <|
                \_ ->
                    let
                        identity : SecureTreasureChest a -> SecureTreasureChest a
                        identity secureTreasureChest =
                            secureTreasureChest
                    in
                    Expect.pass
            ]
        , describe "3"
            [ test "Treasure can be a string" <|
                \_ ->
                    createPassword "12345678"
                        |> Maybe.map (createTreasure "treasure")
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createPassword "12345678" |> Maybe.map (createTreasure "treasure"))
                            ]
            , test "Treasure can be an int" <|
                \_ ->
                    createPassword "12345678"
                        |> Maybe.map (createTreasure 5)
                        |> Expect.all
                            [ Expect.notEqual Nothing
                            , Expect.equal (createPassword "12345678" |> Maybe.map (createTreasure 5))
                            ]
            ]
        , describe "4"
            [ test "The treasure is returned if the correct password is used" <|
                \_ ->
                    createPassword "12345678"
                        |> Maybe.map
                            (createTreasure "treasure")
                        |> Maybe.andThen (getTreasure "12345678")
                        |> Expect.equal (Just "treasure")
            , test "Nothing is returned if password does not match" <|
                \_ ->
                    createPassword "12345678"
                        |> Maybe.map
                            (createTreasure "treasure")
                        |> Maybe.andThen (getTreasure "wrong-password")
                        |> Expect.equal Nothing
            ]
        ]
