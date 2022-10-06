# General

- [Partial application][partial-application] and [|>][pipe-operator] make it easy to write elegant, chained, code, when the main data structure as last argument of functions. All the common functions in the standard library do this, such as `List.map`
- A [Let statement][let] canbe used in `attack` to partially apply the `attackWithSword` and `attachWithClaw` functions with the correct strength for Annalyn and Kazak.

[pipe-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#|%3E
[partial-application]: https://riptutorial.com/elm/example/7499/partial-application
[let]: "https://elmprogramming.com/let-expression.html"
