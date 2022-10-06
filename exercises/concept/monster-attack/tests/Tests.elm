module Tests exposing (tests)

import Expect
import MonsterAttack exposing (attack, attackWithClaw, attackWithSword)
import Test exposing (..)


tests : Test
tests =
    describe "MonsterAttack"
        [ describe "1"
            [ test "attack with sword should update Monster with desired description" <|
                \_ ->
                    attackWithSword 2 ""
                        |> Expect.equal
                            "Attacked with sword of strength 2."
            ]
        , describe "2"
            [ test "attack with claw should update Monster with desired description" <|
                \_ ->
                    attackWithClaw 3 ""
                        |> Expect.equal
                            "Attacked with claw of strength 3."
            ]
        , describe "3"
            [ test "attack should attack with sword twice and claw twice" <|
                \_ ->
                    attack ""
                        |> Expect.equal
                            "Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        ]
