module Tests exposing (tests)

import AnnalynsInfiltration exposing (canFastAttack, canFreePrisoner, canSignalPrisoner, canSpy, stealthAttackDamage)
import Expect
import Test exposing (..)


tests : Test
tests =
    describe "AnnalynsInfiltration"
        [ describe "1"
            [ test "Cannot execute fast attack if knight is awake" <|
                \_ ->
                    let
                        knightIsAwake =
                            True
                    in
                    canFastAttack knightIsAwake
                        |> Expect.equal False
            , test "Can execute fast attack if knight is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            False
                    in
                    canFastAttack knightIsAwake
                        |> Expect.equal True
            ]
        , describe "2"
            [ test "Cannot spy if everyone is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal False
            , test "Can spy if everyone but knight is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if everyone but archer is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if everyone but prisoner is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if only knight is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if only archer is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if only prisoner is sleeping" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Can spy if everyone is awake" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True
                    in
                    canSpy knightIsAwake archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            ]
        , describe "3"
            [ test "Can signal prisoner if archer is sleeping and prisoner is awake" <|
                \_ ->
                    let
                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True
                    in
                    canSignalPrisoner archerIsAwake prisonerIsAwake
                        |> Expect.equal True
            , test "Cannot signal prisoner if archer is awake and prisoner is sleeping" <|
                \_ ->
                    let
                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False
                    in
                    canSignalPrisoner archerIsAwake prisonerIsAwake
                        |> Expect.equal False
            , test "Cannot signal prisoner if archer and prisoner are both sleeping" <|
                \_ ->
                    let
                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False
                    in
                    canSignalPrisoner archerIsAwake prisonerIsAwake
                        |> Expect.equal False
            , test "Cannot signal prisoner if archer and prisoner are both awake" <|
                \_ ->
                    let
                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True
                    in
                    canSignalPrisoner archerIsAwake prisonerIsAwake
                        |> Expect.equal False
            ]
        , describe "4"
            [ test "Cannot release prisoner if everyone is awake and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if everyone is awake and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Can release prisoner if everyone is asleep and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal True
            , test "Cannot release prisoner if everyone is asleep and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Can release prisoner if only prisoner is awake and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal True
            , test "Can release prisoner if only prisoner is awake and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal True
            , test "Cannot release prisoner if only archer is awake and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if only archer is awake and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Can release prisoner if only knight is awake and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal True
            , test "Cannot release prisoner if only knight is awake and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if only knight is asleep and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if only knight is asleep and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            False

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Can release prisoner if only archer is asleep and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal True
            , test "Cannot release prisoner if only archer is asleep and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            False

                        prisonerIsAwake =
                            True

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if only prisoner is asleep and pet dog is present" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            True
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            , test "Cannot release prisoner if only prisoner is asleep and pet dog is absent" <|
                \_ ->
                    let
                        knightIsAwake =
                            True

                        archerIsAwake =
                            True

                        prisonerIsAwake =
                            False

                        petDogIsPresent =
                            False
                    in
                    canFreePrisoner knightIsAwake archerIsAwake prisonerIsAwake petDogIsPresent
                        |> Expect.equal False
            ]
        , describe "5"
            [ test "Annalyn does 12 damage if undetected" <|
                \_ ->
                    let
                        annalynIsDetected =
                            False
                    in
                    stealthAttackDamage annalynIsDetected
                        |> Expect.equal 12
            , test "Annalyn does 7 damage if detected" <|
                \_ ->
                    let
                        annalynIsDetected =
                            True
                    in
                    stealthAttackDamage annalynIsDetected
                        |> Expect.equal 7
            ]
        ]
