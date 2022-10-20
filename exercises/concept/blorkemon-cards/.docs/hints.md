# Hints

## General

- Read the documentation for [comparison operators][comparison-operators]
- Read the documentation for [sorting lists][list-sort]
- Remember how you can [access or pattern match records][records]

## 1. Compare power levels

- Use the [`(>)` operator][greater]

## 2. Find the highest power

- Use the [`max` function][max]

## 3. Sort the cards

- Use the [`List.sortBy` function][sort-by]

## 4. Coolest cards first

- Use the [`List.sortBy`][sort-by] or [`List.sortWith`][sort-with] functions
- You can use tuples for hierarchical sorts

## 5. Shiny Power

- You could explicitly define an order or use the [`compare` function][compare] with specific value
- You can use tuples for hierarchical sorts

## 6. Place your bets

- Use `compareShinyPower` in `expectedWinner`
- Use a `case` to [pattern match the order][pattern-match]

[comparison-operators]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(%3C)
[list-sort]: https://package.elm-lang.org/packages/elm/core/latest/List#sort
[records]: https://elm-lang.org/docs/records
[greater]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(%3E)
[max]: https://package.elm-lang.org/packages/elm/core/latest/Basics#max
[sort-by]: https://package.elm-lang.org/packages/elm/core/latest/List#sortBy
[sort-with]: https://package.elm-lang.org/packages/elm/core/latest/List#sortWith
[compare]: https://package.elm-lang.org/packages/elm/core/latest/Basics#compare
[pattern-match]: https://guide.elm-lang.org/types/pattern_matching.html
