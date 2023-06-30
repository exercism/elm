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
                    attackWithSword1 "A monster approaches Annalyn and her pet dog Kazak. " 2
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with sword of strength 2."
            ]
        , describe "2"
            [ test "attackWithClaw1 should update Monster with desired description" <|
                \_ ->
                    attackWithClaw1 "A monster approaches Annalyn and her pet dog Kazak. " 3
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with claw of strength 3."
            ]
        , describe "3"
            [ test "attack1 should attack with sword twice and claw twice" <|
                \_ ->
                    attack1 "A monster approaches Annalyn and her pet dog Kazak. "
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        , describe "4"
            [ test "attackWithSword2 should update Monster with desired description" <|
                \_ ->
                    attackWithSword2 2 "A monster approaches Annalyn and her pet dog Kazak. "
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with sword of strength 2."
            ]
        , describe "5"
            [ test "attackWithClaw2 should update Monster with desired description" <|
                \_ ->
                    attackWithClaw2 3 "A monster approaches Annalyn and her pet dog Kazak. "
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with claw of strength 3."
            ]
        , describe "6"
            [ test "attack2 should attack with sword twice and claw twice" <|
                \_ ->
                    attack2 "A monster approaches Annalyn and her pet dog Kazak. "
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        , describe "7"
            [ test "attack3 should attack with sword twice and claw twice" <|
                \_ ->
                    attack3 "A monster approaches Annalyn and her pet dog Kazak. "
                        |> Expect.equal
                            "A monster approaches Annalyn and her pet dog Kazak. Attacked with sword of strength 5.Attacked with claw of strength 1.Attacked with claw of strength 1.Attacked with sword of strength 5."
            ]
        ]
