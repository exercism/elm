# Instructions

In this exercise, you'll be implementing the quest logic for a new RPG game a friend is developing. The game's main character is Annalyn, a brave girl with a fierce and loyal pet dog Kazak. At one point they are ambushed by a monster which they attack.

## 1. Define attackWithSword

Define `attackWithSword`. This should take a String (that describes the monster) and an Int that indicates how strong the attack is. It should return the existing string, with "Attacked with sword of strength <strength>." appended to the end. Pay attention to the order of the function parameters.

## 2. Define attackWithClaw

Define `attackWithClaw`. This should take a String (that describes the monster) and an Int that indicates how strong the attack is. It should return the existing string, with "Attacked with claw of strength <strength>." appended to the end. Pay attention to the order of the function parameters.

## 3. Define attack

Annalyn attacks with a sword, and she has a strength of 5.

Her loyal pet dog Kazak attacks with its claws, and has a strength of 1.

Define `attack`. This should take a String (that describes the monster), and perform the following attacks, in the correct order:

- Annalyn
- Kazak
- Kazak
- Annalyn

The most elegant way to write the function involves [Partial application][partial-application] and the [pipe operator(`|>`)][pipe-operator].

[pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#|%3E
[partial-application]: https://riptutorial.com/elm/example/7499/partial-application
