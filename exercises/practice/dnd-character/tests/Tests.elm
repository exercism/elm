module Tests exposing (tests)

import DndCharacter
import Expect
import Fuzz
import Set
import Test exposing (Test, describe, fuzz, fuzzWith, skip, test)
import Test.Distribution


tests : Test
tests =
    describe "DndCharacter"
        [ describe "modifier"
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
        , describe "ability"
            [ skip <|
                fuzzWith { runs = 1000, distribution = Test.noDistribution }
                    (Fuzz.fromGenerator DndCharacter.ability)
                    "generated ability should be at least 3"
                <|
                    \ability -> Expect.atLeast 3 ability
            , skip <|
                fuzzWith { runs = 1000, distribution = Test.noDistribution }
                    (Fuzz.fromGenerator DndCharacter.ability)
                    "generated ability should be at most 18"
                <|
                    \ability -> Expect.atMost 18 ability
            , skip <|
                fuzzWith
                    { runs = 10000
                    , distribution =
                        Test.expectDistribution
                            [ ( Test.Distribution.moreThanZero, "is 3", (==) 3 ) ]
                    }
                    (Fuzz.fromGenerator DndCharacter.ability)
                    "generated ability should sometimes be 3"
                <|
                    \_ -> Expect.pass
            , skip <|
                fuzzWith
                    { runs = 1000
                    , distribution =
                        Test.expectDistribution
                            [ ( Test.Distribution.moreThanZero, "is 18", (==) 18 ) ]
                    }
                    (Fuzz.fromGenerator DndCharacter.ability)
                    "generated ability should sometimes be 18"
                <|
                    \_ -> Expect.pass
            , skip <|
                fuzzWith
                    { runs = 10000
                    , distribution =
                        Test.expectDistribution
                            [ ( Test.Distribution.atLeast 10, "is 13", (==) 13 )
                            , ( Test.Distribution.atLeast 85, "is not 13", (/=) 13 )
                            ]
                    }
                    (Fuzz.fromGenerator DndCharacter.ability)
                    "13 has an approximate 13% chance of being picked"
                <|
                    \_ -> Expect.pass
            ]
        , describe "character"
            [ skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character strength should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.strength
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character dexterity should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.dexterity
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character constitution should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.constitution
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character intelligence should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.intelligence
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character wisdom should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.wisdom
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character charisma should be within range"
                <|
                    \character ->
                        Expect.all [ Expect.atLeast 3, Expect.atMost 18 ] character.charisma
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character hitpoints should be 10 plus the constitution modifier"
                <|
                    \character ->
                        Expect.equal character.hitpoints (10 + DndCharacter.modifier character.constitution)
            , skip <|
                fuzz (Fuzz.fromGenerator DndCharacter.character)
                    "generated character abilities are not all equal"
                <|
                    \character ->
                        let
                            uniqueAbilities { strength, dexterity, constitution, intelligence, wisdom, charisma } =
                                [ strength, dexterity, constitution, intelligence, wisdom, charisma ]
                                    |> Set.fromList
                                    |> Set.size
                        in
                        Expect.atLeast 2 (uniqueAbilities character)
            , skip <|
                fuzzWith
                    { runs = 1000
                    , distribution =
                        Test.expectDistribution
                            [ ( Test.Distribution.atLeast 40, "has low charisma", \char -> char.charisma <= 12 )
                            , ( Test.Distribution.atLeast 40, "has high charisma", \char -> char.charisma > 12 )
                            , ( Test.Distribution.atLeast 40, "has low strength", \char -> char.strength <= 12 )
                            , ( Test.Distribution.atLeast 40, "has high strength", \char -> char.strength > 12 )
                            ]
                    }
                    (Fuzz.fromGenerator DndCharacter.character)
                    "generated characters are not all equal"
                <|
                    \_ -> Expect.pass
            ]
        ]
