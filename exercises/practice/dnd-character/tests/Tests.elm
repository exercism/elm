module Tests exposing (tests)

import DndCharacter exposing (Character)
import Expect
import Random exposing (Generator, Seed)
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
                    generateValuesFromSeed 1000 DndCharacter.ability (Random.initialSeed 42)
                        |> List.all (\score -> 3 <= score && score <= 18)
                        |> Expect.equal True
        , skip <|
            test "random character is valid" <|
                \() ->
                    let
                        validCharacter { strength, dexterity, constitution, intelligence, wisdom, charisma, hitpoints } =
                            (strength >= 3)
                                && (strength <= 18)
                                && (dexterity >= 3)
                                && (dexterity <= 18)
                                && (constitution >= 3)
                                && (constitution <= 18)
                                && (intelligence >= 3)
                                && (intelligence <= 18)
                                && (wisdom >= 3)
                                && (wisdom <= 18)
                                && (charisma >= 3)
                                && (charisma <= 18)
                                && (hitpoints == 10 + DndCharacter.modifier constitution)
                    in
                    generateValuesFromSeed 1000 DndCharacter.character (Random.initialSeed 42)
                        |> List.all validCharacter
                        |> Expect.equal True
        ]
