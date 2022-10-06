module MonsterAttack exposing (attack)


type alias Monster =
    String


attackWithSword : Int -> Monster -> Monster
attackWithSword strength monster =
    monster ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."


attackWithClaw : Int -> Monster -> Monster
attackWithClaw strength monster =
    monster ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."


attack : Monster -> Monster
attack monster =
    let
        annalynAttack =
            attackWithSword 5

        kazakAttack =
            attackWithClaw 1
    in
    monster
        |> annalynAttack
        |> kazakAttack
        |> kazakAttack
        |> annalynAttack
