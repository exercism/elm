# Hints

## General

- Read the documentation for [comparison operators][comparison-operators]
- Read the documentation for [sorting lists][list-sort]
- Remember that you can [pattern match tuples][tuples]

## 1. Compare power levels

- Remember that you can [pattern match tuples][tuples]
- Use the [`(>)` operator][greater]

## 2. Find the highest power

- Use the [`max` function][max]

## 3. Sort the cards

- Use the [`List.sortBy` function][sort-by]

## 4. Coolest cards first

- Use the [`List.sortBy`][sort-by] or [`List.sortWith`][sort-with] functions
- Tuples are compared in the lexicographical order

## 5. Shiny Power

- You could explicitly define an order or use the [`compare` function][compare] with specific value
- Tuples are compared in the lexicographical order

## 6. Place your bets

- Use `compareShinyPower` in `expectedWinner`
- Use a `case` to [pattern match the order][pattern-match]

[comparison-operators]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(%3C)
[list-sort]: https://package.elm-lang.org/packages/elm/core/latest/List#sort
[tuples]: https://www.bekk.christmas/post/2020/1/once-twice-three-times-a-value
[greater]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(%3E)
[max]: https://package.elm-lang.org/packages/elm/core/latest/Basics#max
[sort-by]: https://package.elm-lang.org/packages/elm/core/latest/List#sortBy
[sort-with]: https://package.elm-lang.org/packages/elm/core/latest/List#sortWith
[compare]: https://package.elm-lang.org/packages/elm/core/latest/Basics#compare
[pattern-match]: https://guide.elm-lang.org/types/pattern_matching.html
