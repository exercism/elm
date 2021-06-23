# Instructions

In this exercise, you'll be implementing mechanics of a role-playing game.
A player's character is represented by the following type:

```elm
type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }
```

Players in this game must reach level 10 before they unlock a mana pool so that they can start casting spells.
You're working on two pieces of functionality in this game, the revive mechanic and the spell casting mechanic.

## 1. Introduce yourself

Write the content of the `introduce` function.
Stealthy players may be hiding their name and will be introduced as `"Mighty Magician"`.
Otherwise, just use your name to introduce yourself.

```elm
introduce { name = Nothing, level = 2, health = 8, mana = Nothing }
    --> "Mighty Magician"

introduce { name = Just "Merlin", level = 2, health = 8, mana = Nothing }
    --> "Merlin"
```

## 2. Implement the revive mechanic

The `revive` function should check that the player's character is indeed dead (their health has reached 0).
If they are, it should return a new `Player` instance with 100 health.
Otherwise, if the player's character isn't dead, the `revive` function returns `Nothing`.

If the player's level is 10 or above, they should also be revived with 100 mana.
If they player's level is below 10, their mana should be `Nothing`.
The `revive` function should preserve the player's level.

```elm
deadPlayer = { name = Nothing, level = 2, health = 0, mana = Nothing }

revive deadPlayer
    --> Just { name = Nothing, level = 2, health = 100, mana = Nothing }
```

If the `revive` method is called on a player whose health is 1 or above, then the function should return `Nothing`.

```elm
alivePlayer = { name = Nothing, level = 2, health = 42, mana = Nothing }

revive alivePlayer
    --> Nothing
```

## 3. Implement the spell casting mechanic

The `castSpell` function takes as arguments an `Int` indicating how much mana the spell costs as well as a `Player`.
It returns the updated player, as well as the amount of damage that the cast spell performs.
A successful spell cast does damage equal to two times the mana cost of the spell.
However, if the player has insufficient mana, nothing happens, the player is unchanged and no damage is done.
If the player does not even have a mana pool, attempting to cast the spell must decrease their health by the mana cost of the spell and does no damage.

```elm
wizard = { name = Nothing, level = 18, health = 123, mana = Just 30 }

( updatedWizard, damage ) = castSpell 14 wizard

updatedWizard.mana --> Just 16
damage             --> 28
```
