module DndCharacter exposing (Character, ability, character, modifier)

import Random exposing (Generator)


type alias Character =
    { strength : Int
    , dexterity : Int
    , constitution : Int
    , intelligence : Int
    , wisdom : Int
    , charisma : Int
    , hitpoints : Int
    }


modifier : Int -> Int
modifier score =
    floor ((toFloat score - 10) / 2)


ability : Generator Int
ability =
    let
        sumOfMaxThree =
            List.sort >> List.reverse >> List.take 3 >> List.sum
    in
    Random.list 4 (Random.int 1 6)
        |> Random.map sumOfMaxThree


character : Generator Character
character =
    Random.constant Character
        |> apply ability
        |> apply ability
        |> apply ability
        |> apply ability
        |> apply ability
        |> apply ability
        |> apply (Random.constant 0)
        |> Random.map fixHitpoints


apply : Generator a -> Generator (a -> b) -> Generator b
apply genA =
    Random.andThen (\aToB -> Random.map aToB genA)


fixHitpoints : Character -> Character
fixHitpoints ({ constitution } as zeroHpCharacter) =
    { zeroHpCharacter | hitpoints = 10 + modifier constitution }
