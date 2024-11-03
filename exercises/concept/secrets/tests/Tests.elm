module Tests exposing (tests)

import Expect
import Secrets exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Secrets"
        [ describe "1"
            [ test "Shift 8 right by 2" <|
                \_ ->
                    shiftBack 2 8
                    |> Expect.equal 2
            , test "Shift -8 right by 2" <|
                \_ ->
                    shiftBack 2 -8
                        |> Expect.equal 1073741822
            ]
        , describe "2"
            [ test "Set bits in 5" <|
                \_ ->
                    setBits 3 5
                        |> Expect.equal 7
            , test "Set bits in 5,652" <|
                \_ ->
                    setBits 26150 5652
                        |> Expect.equal 30262
            ]
        , describe "3"
            [ test "Flip bits in 5" <|
                \_ ->
                    flipBits 11 5
                        |> Expect.equal 14
            , test "Flip bits in 38460" <|
                \_ ->
                    flipBits 15471 38460
                        |> Expect.equal 43603
            
            ]
        , describe "4"
            [ test "Clear bits from 5" <|
                \_ ->
                    clearBits 11 5
                        |> Expect.equal 4
            , test "Clear bits from 90" <|
                \_ ->
                    clearBits 240 90
                        |> Expect.equal 10
            ]
        ]
