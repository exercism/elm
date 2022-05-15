module Tests exposing (tests)

import Expect
import RolePlayingGame exposing (Player, castSpell, introduce, revive)
import Test exposing (..)


tests : Test
tests =
    describe "RolePlayingGame"
        [ describe "1"
            [ test "Introducing someone with their name" <|
                \() ->
                    Expect.equal (introduce { name = Just "Gandalf", level = 1, health = 42, mana = Nothing }) "Gandalf"
            , test "Introducing an unidentified player should return 'Mighty Magician'" <|
                \() ->
                    Expect.equal (introduce { name = Nothing, level = 1, health = 42, mana = Nothing }) "Mighty Magician"
            ]
        , describe "2"
            [ test "Attempting to revive a player that is alive should return Nothing" <|
                \() ->
                    Expect.equal (revive { name = Nothing, level = 12, health = 42, mana = Just 7 }) Nothing
            , test "Reviving a low level player resets its health to 100" <|
                \() ->
                    Expect.equal (revive { name = Nothing, level = 3, health = 0, mana = Nothing })
                        (Just { name = Nothing, level = 3, health = 100, mana = Nothing })
            , test "Reviving a high level player resets both its health and mana" <|
                \() ->
                    Expect.equal (revive { name = Nothing, level = 10, health = 0, mana = Just 14 })
                        (Just { name = Nothing, level = 10, health = 100, mana = Just 100 })
            ]
        , describe "3"
            [ test "Casting a spell spends double the mana" <|
                \() ->
                    Expect.equal (castSpell 9 { name = Nothing, level = 10, health = 69, mana = Just 20 })
                        ( { name = Nothing, level = 10, health = 69, mana = Just 11 }, 18 )
            , test "Attempting to cast a spell with insufficient mana does nothing" <|
                \() ->
                    Expect.equal (castSpell 39 { name = Nothing, level = 10, health = 69, mana = Just 20 })
                        ( { name = Nothing, level = 10, health = 69, mana = Just 20 }, 0 )
            , test "Attempting to cast a spell without a mana pool decreases the player's health" <|
                \() ->
                    Expect.equal (castSpell 7 { name = Nothing, level = 5, health = 58, mana = Nothing })
                        ( { name = Nothing, level = 5, health = 51, mana = Nothing }, 0 )
            , test "A player's health cannot go below 0" <|
                \() ->
                    Expect.equal (castSpell 12 { name = Nothing, level = 5, health = 6, mana = Nothing })
                        ( { name = Nothing, level = 5, health = 0, mana = Nothing }, 0 )
            ]
        ]
