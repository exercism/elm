# Hints

## General

- The documentation for the `Random` package can be found [here][random-module]

## 1. Start with the end

- Use the [`Random.constant`][random-constant] function

## 2. You can't catch flies with vinegar

- Use the [`Random.uniform`][random-uniform] function for generating the treasures
- Use the [`Random.map`][random-map] function for wrapping the treasure

## 3. Branching out

- Use the [`Random.int`][random-int] function for generating a value between 2 and 4
- You can access this value to create a `Branch` with the [`Random.andThen`][random-andThen] function
- Use the [`Random.list`][random-list] function to generate the branches
- Use the [`Random.map`][random-map] function for wrapping the branches

## 4. Amazing mazes

- Use the [`Random.weighted`][random-weighted] function for generating an uneven distribution of outcomes
- Use the [`Random.lazy`][random-lazy] function for using a generator recursively
- Read more about defining recursive data structures [here][bad-recursion]
- If you end up defining a nested `Generator (Generator Maze)` generator, you can use [`Random.andThen`][random-andThen] together with the `identity` function to flatten it

## 5. We have to go deeper

- Use the [`Random.uniform`][random-uniform] function for generating the dead ends or rooms in on depth `0`
- If you end up defining a nested `Generator (Generator Maze)` generator, you can use the [`Random.andThen`][random-andThen] function to flatten it
- Use the [`Random.lazy`][random-lazy] function for using a generator recursively
- Read more about defining recursive data structures [here][bad-recursion]

[random-module]: https://package.elm-lang.org/packages/elm/random/latest/
[random-constant]: https://package.elm-lang.org/packages/elm/random/latest/Random#constant
[random-uniform]: https://package.elm-lang.org/packages/elm/random/latest/Random#uniform
[random-map]: https://package.elm-lang.org/packages/elm/random/latest/Random#map
[random-int]: https://package.elm-lang.org/packages/elm/random/latest/Random#int
[random-andThen]: https://package.elm-lang.org/packages/elm/random/latest/Random#andThen
[random-list]: https://package.elm-lang.org/packages/elm/random/latest/Random#list
[random-weighted]: https://package.elm-lang.org/packages/elm/random/latest/Random#weighted
[random-lazy]: https://package.elm-lang.org/packages/elm/random/latest/Random#lazy
[bad-recursion]: https://github.com/elm/compiler/blob/master/hints/bad-recursion.md
