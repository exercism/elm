module Tests exposing (tests)

import Dict
import DndCharacter exposing (Character)
import Expect
import Random exposing (Generator, Seed)
import Set
import Test exposing (Test, describe, skip, test)


generateValuesFromSeed : Int -> Generator a -> Seed -> List a
generateValuesFromSeed size generator seed =
    if size <= 0 then
        []

    else
        let
            ( value, nextSeed ) =
                Random.step generator seed
        in
        value :: generateValuesFromSeed (size - 1) generator nextSeed


generate1000Abilities : List Int
generate1000Abilities =
    generateValuesFromSeed 1000 DndCharacter.ability (Random.initialSeed 42)


generate1000Characters : List Character
generate1000Characters =
    generateValuesFromSeed 1000 DndCharacter.character (Random.initialSeed 42)


tests : Test
tests =
    describe "DndCharacter"
        [ describe "ability modifier"
            [ test "ability modifier for score 3 is -4" <|
                \() ->
                    DndCharacter.modifier 3
                        |> Expect.equal -4
            , skip <|
                test "ability modifier for score 4 is -3" <|
                    \() ->
                        DndCharacter.modifier 4
                            |> Expect.equal -3
            , skip <|
                test "ability modifier for score 5 is -3" <|
                    \() ->
                        DndCharacter.modifier 5
                            |> Expect.equal -3
            , skip <|
                test "ability modifier for score 6 is -2" <|
                    \() ->
                        DndCharacter.modifier 6
                            |> Expect.equal -2
            , skip <|
                test "ability modifier for score 7 is -2" <|
                    \() ->
                        DndCharacter.modifier 7
                            |> Expect.equal -2
            , skip <|
                test "ability modifier for score 8 is -1" <|
                    \() ->
                        DndCharacter.modifier 8
                            |> Expect.equal -1
            , skip <|
                test "ability modifier for score 9 is -1" <|
                    \() ->
                        DndCharacter.modifier 9
                            |> Expect.equal -1
            , skip <|
                test "ability modifier for score 10 is 0" <|
                    \() ->
                        DndCharacter.modifier 10
                            |> Expect.equal 0
            , skip <|
                test "ability modifier for score 11 is 0" <|
                    \() ->
                        DndCharacter.modifier 11
                            |> Expect.equal 0
            , skip <|
                test "ability modifier for score 12 is +1" <|
                    \() ->
                        DndCharacter.modifier 12
                            |> Expect.equal 1
            , skip <|
                test "ability modifier for score 13 is +1" <|
                    \() ->
                        DndCharacter.modifier 13
                            |> Expect.equal 1
            , skip <|
                test "ability modifier for score 14 is +2" <|
                    \() ->
                        DndCharacter.modifier 14
                            |> Expect.equal 2
            , skip <|
                test "ability modifier for score 15 is +2" <|
                    \() ->
                        DndCharacter.modifier 15
                            |> Expect.equal 2
            , skip <|
                test "ability modifier for score 16 is +3" <|
                    \() ->
                        DndCharacter.modifier 16
                            |> Expect.equal 3
            , skip <|
                test "ability modifier for score 17 is +3" <|
                    \() ->
                        DndCharacter.modifier 17
                            |> Expect.equal 3
            , skip <|
                test "ability modifier for score 18 is +4" <|
                    \() ->
                        DndCharacter.modifier 18
                            |> Expect.equal 4
            ]
        , skip <|
            test "random ability is within range" <|
                \() ->
                    generate1000Abilities
                        |> List.all (\score -> 3 <= score && score <= 18)
                        |> Expect.equal True
        , skip <|
            test "ability distribution is not uniform" <|
                \() ->
                    let
                        count k rolls =
                            List.length (List.filter ((==) k) rolls)
                    in
                    generate1000Abilities
                        |> Expect.all
                            [ \rolls -> Expect.greaterThan (count 3 rolls) (count 4 rolls)
                            , \rolls -> Expect.greaterThan (count 4 rolls) (count 5 rolls)
                            , \rolls -> Expect.greaterThan (count 5 rolls) (count 6 rolls)
                            , \rolls -> Expect.greaterThan (20 * count 4 rolls) (count 12 rolls)
                            , \rolls -> Expect.lessThan (count 15 rolls) (count 16 rolls)
                            , \rolls -> Expect.lessThan (count 16 rolls) (count 17 rolls)
                            , \rolls -> Expect.lessThan (count 17 rolls) (count 18 rolls)
                            ]
        , skip <|
            test "random character is valid" <|
                \() ->
                    let
                        validCharacter { strength, dexterity, constitution, intelligence, wisdom, charisma, hitpoints } =
                            ((3 <= strength) && (strength <= 18))
                                && ((3 <= dexterity) && (dexterity <= 18))
                                && ((3 <= constitution) && (constitution <= 18))
                                && ((3 <= intelligence) && (intelligence <= 18))
                                && ((3 <= wisdom) && (wisdom <= 18))
                                && ((3 <= charisma) && (charisma <= 18))
                                && (hitpoints == 10 + DndCharacter.modifier constitution)
                    in
                    generate1000Characters
                        |> List.all validCharacter
                        |> Expect.equal True
        , skip <|
            test "random characters are not all the same" <|
                \() ->
                    generate1000Characters
                        |> List.map .strength
                        |> Set.fromList
                        |> Set.size
                        |> Expect.atLeast 10
        , skip <|
            test "random character has independent abilities" <|
                \() ->
                    let
                        hasFourDifferentAbilities { strength, dexterity, constitution, intelligence, wisdom, charisma } =
                            Set.fromList [ strength, dexterity, constitution, intelligence, wisdom, charisma ]
                                |> Set.size
                                |> (==) 4
                    in
                    generate1000Characters
                        |> List.any hasFourDifferentAbilities
                        |> Expect.equal True
        ]
