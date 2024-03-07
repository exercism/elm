# Hints

## General

- You will need to import the [Dict module][dict-module].

## 1. Aggregate scorers

- It is probably easiest to define an update function and use `Dict.update` in `updateGoalCountForPlayer`.

## 2. Remove insignificant players

- `Dict.filter` is easiest for this.

## 3. Reset player goal count

- `Dict.insert` is easiest for this.

## 4. Format the goal count for a single player

- `Dict.get`, `Maybe.map` and `Maybe.withDefault` are useful for this.

## 5. Format the goal count for all players

- `Dict.toList`, `List.map` and `String.join` are useful for this. `sort` is not required.

## 6. Combine games

- `Dict.merge` is easiest for this.

[dict-module]: https://package.elm-lang.org/packages/elm/core/latest/Dict
