module MonsterAttack exposing (..)


type alias MonsterDamage =
    String


attackWithSword1 : MonsterDamage -> Int -> MonsterDamage
attackWithSword1 monsterDamage strength =
    monsterDamage ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."


attackWithClaw1 : MonsterDamage -> Int -> MonsterDamage
attackWithClaw1 monsterDamage strength =
    monsterDamage ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."


attack1 : MonsterDamage -> MonsterDamage
attack1 monsterDamage =
    let
        monsterDamage1 =
            attackWithSword1 monsterDamage 5

        monsterDamage2 =
            attackWithClaw1 monsterDamage1 1

        monsterDamage3 =
            attackWithClaw1 monsterDamage2 1

        monsterDamage4 =
            attackWithSword1 monsterDamage3 5
    in
    monsterDamage4


attackWithSword2 : Int -> MonsterDamage -> MonsterDamage
attackWithSword2 strength monsterDamage =
    monsterDamage ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."


attackWithClaw2 : Int -> MonsterDamage -> MonsterDamage
attackWithClaw2 strength monsterDamage =
    monsterDamage ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."


attack2 : MonsterDamage -> MonsterDamage
attack2 monsterDamage =
    let
        annalynAttack =
            attackWithSword2 5

        kazakAttack =
            attackWithClaw2 1
    in
    monsterDamage
        |> annalynAttack
        |> kazakAttack
        |> kazakAttack
        |> annalynAttack


attack3 : MonsterDamage -> MonsterDamage
attack3 =
    let
        annalynAttack =
            attackWithSword2 5

        kazakAttack =
            attackWithClaw2 1
    in
    annalynAttack >> kazakAttack >> kazakAttack >> annalynAttack
