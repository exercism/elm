# Instructions

In this exercise, you'll be implementing the quest logic for a new RPG game a friend is developing.
The game's main character is Annalyn, a brave girl with a fierce and loyal pet dog Kazak.
At one point they are ambushed by a monster which they attack.

## 1. Define attackWithSword1

Define `attackWithSword1`.
This should take a `MonsterDamage` (a `String` that describes the damage to the monster) and an `Int` that indicates how strong the attack is.
It should return the existing string, with "Attacked with sword of strength {strength}." appended to the end.

## 2. Define attackWithClaw1

Define `attackWithClaw1`.
This should take a `MonsterDamage` and an `Int` that indicates how strong the attack is.
It should return the existing string, with "Attacked with claw of strength {strength}." appended to the end.

## 3. Define attack1

Annalyn attacks with a sword, and she has a strength of 5.

Her loyal pet dog Kazak attacks with its claws, and has a strength of 1.

Define `attack1`. This should take a `MonsterDamage` and perform the following attacks, in the correct order:

- Annalyn
- Kazak
- Kazak
- Annalyn

The implementation of this function will be a bit cumbersome, as `attackWithSword1` and `attackWithClaw1` do not have the main data structure (`MonsterDamage`) as the last parameter (they are not doing it in the recommended way).
It is not possible / advisable to use partial application in this initial case.

## 4. Define attackWithSword2

Define `attackWithSword2`.
This is the same as `attackWithSword1`, except the parameters are swapped.

## 5. Define attackWithClaw2

Define `attackWithClaw2`.
This is the same as `attackWithClaw2`, except the parameters are swapped.

## 6. Define attack2

Define `attack2`.

This is the same as `attack1`, but should use `attackWithSword2` and `attackWithClaw2`.

Please implement the function using [Partial application][partial-application] and the [pipe operator `(|>)`][pipe-operator].
The implementation should now be more elegant, as `attackWithSword2` and `attackWithClaw2` have `MonsterDamage` (the main data structure) as the last parameter, as is recommended.

## 7. Define attack3

Define `attack3`.

This is the same as `attack2`, but should be implemented using function composition / the [`(>>)`][forward-composition] operator.

This implementation should also be elegant, and smaller than `attack2`, although potentially harder to understand.

[pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#|%3E
[partial-application]: https://riptutorial.com/elm/example/7499/partial-application
[forward-composition]: https://package.elm-lang.org/packages/elm/core/latest/Basics#%3E%3E
