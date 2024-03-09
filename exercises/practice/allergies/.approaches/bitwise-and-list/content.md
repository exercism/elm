# Bitwise and List

```elm
allergies : List Allergy
allergies =
    [ Eggs
    , Peanuts
    , Shellfish
    , Strawberries
    , Tomatoes
    , Chocolate
    , Pollen
    , Cats
    ]

toList : Int -> List Allergy
toList score =
  allergies
    |> List.indexedMap (\i allergy -> ( 2 ^ i, allergy ))
    |> List.filter (\( allergyScore, _ ) -> Bitwise.and allergyScore score > 0)
    |> List.map Tuple.second

isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
  toList score |> List.member allergy    
```

## In this approach

This approach implicitly uses the index of an item in a list to represent the bit position (minus one) for the allergy score.

[`List.indexedMap`][list-indexed-map] is used to map the list and provide the index of each item, it retains the `Allergy` and adds the bit mask in a tuple.
[`List.filter`][list-filter] then filters out any `Allergy` in the list where the bit mask doesn't match the score using [`Bitwise.and`][bitwise-and].
[`List.map`][list-map] and [`Tuple.second`][tuple-second] then map the filtered list from `Tuple` back to `Allergy`.

You can see [the Bitwise and List solution on exercism][bitwise-and-list-solution].

## When to use this approach?

This code is idiomatic in Elm and is probably the solution many Elm developers would naturally end up with first.
It is also the example solution to the exercise and is concise.

This approach does not embed the domain concept of using bit positions in an `Int` to represent a list of `Allergy`.
It is relatively easy to work out what the code is doing, but it is not as easy to guess why it is doing it, you have to look at the exercise instructions to understand.
Ideally the code should communicate its meaning to you.

`toList` is a relatively expensive operation, iterating the `allergies` twice, or O(2n).
We can't use [List.foldr][list-foldr] to avoid this, as it doesn't provide the list index, and there is no "indexedFoldr" function available from the core libraries.
`isAllergicTo` is also a relatively expensive operation, iterating the `allergies` list three times or O(3n). However this list is a known and very small length, so for this exercise we should not try to prematurely optimise.

The compiler does not guarantee that the `allergies` list contains all the `Allergy` types.
You can use the [type iterator pattern][type-iterator-pattern] or use the [no missing type constructor][elm-review-no-missing-type-constructor] rule in [Elm Review][elm-review] to fix this.

This approach guarantees all bit positions are valid (unless the number of allergies becomes too big).

This approach also guarantees that all bit positions are sequential.
This is potentially useful, but means that if there was ever a need for non sequential bit positions, we would have to refactor.

[list-indexed-map]:
  https://package.elm-lang.org/packages/elm/core/latest/List#indexedMap
  "List.indexedMap documentation"
[list-filter]:
  https://package.elm-lang.org/packages/elm/core/latest/List#filter
  "List.filter documentation"
[bitwise-and]:
  https://package.elm-lang.org/packages/elm/core/latest/Bitwise#and
  "Bitwise.and documentation"
[list-map]:
  https://package.elm-lang.org/packages/elm/core/latest/List#map
  "List.map documentation"
[tuple-second]:
  https://package.elm-lang.org/packages/elm/core/latest/Tuple#second
  "Tuple.second documentation"
[type-iterator-pattern]:
  https://sporto.github.io/elm-patterns/basic/type-iterator.html
  "The type iterator pattern"
[elm-review]:
  https://github.com/jfmengels/elm-review
  "Elm Review"
[elm-review-no-missing-type-constructor]:
  https://package.elm-lang.org/packages/Arkham/elm-review-no-missing-type-constructor/latest/
  "No Missing Type Constucture rule for Elm Review
[bitwise-and-list-solution]:
  https://exercism.org/tracks/elm/exercises/allergies/solutions/ceddlyburge
  "Bitwise and List solution on exercism"
[List-foldr]:
  https://package.elm-lang.org/packages/elm/core/latest/List#foldr
  "List.foldr documentation"
