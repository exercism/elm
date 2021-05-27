module Tests exposing (tests)

import Expect
import RolePlayingGame exposing (Player, castSpell, revive)
import Test exposing (..)


tests : Test
tests =
    describe "RolePlayingGame"
        [ test "Attempting to revive a player that is alive should return Nothing" <|
            \() -> Expect.equal (revive { level = 12, health = 42, mana = Just 7 }) Nothing
        , test "Reviving a low level player resets its health to 100" <|
            \() ->
                Expect.equal (revive { level = 3, health = 0, mana = Nothing })
                    (Just { level = 3, health = 100, mana = Nothing })
        , test "Reviving a high level player resets both its health and mana" <|
            \() ->
                Expect.equal (revive { level = 10, health = 0, mana = Just 14 })
                    (Just { level = 10, health = 100, mana = Just 100 })
        , test "Casting a spell spends double the mana" <|
            \() ->
                Expect.equal (castSpell 9 { level = 10, health = 69, mana = Just 20 })
                    ( { level = 10, health = 69, mana = Just 11 }, 18 )
        , test "Attempting to cast a spell with insufficient mana does nothing" <|
            \() ->
                Expect.equal (castSpell 39 { level = 10, health = 69, mana = Just 20 })
                    ( { level = 10, health = 69, mana = Just 20 }, 0 )
        , test "Attempting to cast a spell without a mana pool decreases the player's health" <|
            \() ->
                Expect.equal (castSpell 7 { level = 5, health = 58, mana = Nothing })
                    ( { level = 5, health = 51, mana = Nothing }, 0 )
        , test "A player's health cannot go below 0" <|
            \() ->
                Expect.equal (castSpell 12 { level = 5, health = 6, mana = Nothing })
                    ( { level = 5, health = 0, mana = Nothing }, 0 )
        ]
