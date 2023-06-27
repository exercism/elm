module Tests exposing (tests)

import Expect
import MonsterAttack exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "MonsterAttack"
        [ describe "1"
            [ test "attackWithSword1 should update Monster with desired description" <|
                \_ ->
                    attackWithSword1 "Monster damage. " 2
                        |> Expect.equal
                            "Monster damage. Attacked with sword of strength 2."
            ]
        , describe "2"
            [ test "attackWithClaw1 should update Monster with desired description" <|
                \_ ->
                    attackWithClaw1 "Monster damage. " 3
                        |> Expect.equal
                            "Monster damage. Attacked with claw of strength 3."
            ]
        , describe "3"
            [ test "attack1 should attack with sword twice and claw twice" <|
                \_ ->
                    attack1 "Monster damage. "
                        |> Expect.equal
                            "Monster damage. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        , describe "4"
            [ test "attackWithSword2 should update Monster with desired description" <|
                \_ ->
                    attackWithSword2 2 "Monster damage. "
                        |> Expect.equal
                            "Monster damage. Attacked with sword of strength 2."
            ]
        , describe "5"
            [ test "attackWithClaw2 should update Monster with desired description" <|
                \_ ->
                    attackWithClaw2 3 "Monster damage. "
                        |> Expect.equal
                            "Monster damage. Attacked with claw of strength 3."
            ]
        , describe "6"
            [ test "attack2 should attack with sword twice and claw twice" <|
                \_ ->
                    attack2 "Monster damage. "
                        |> Expect.equal
                            "Monster damage. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        , describe "7"
            [ test "attack3 should attack with sword twice and claw twice" <|
                \_ ->
                    attack3 "Monster damage. "
                        |> Expect.equal
                            "Monster damage. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        ]
