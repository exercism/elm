# Bitwise and case expression

```elm
intToAllergen : Int -> Maybe Allergy
intToAllergen x =
  case x of
    1 ->
        Just Eggs
    2 ->
        Just Peanuts
    4 ->
        Just Shellfish
    8 ->
        Just Strawberries
    16 ->
        Just Tomatoes
    32 ->
        Just Chocolate
    64 ->
        Just Pollen
    128 ->
        Just Cats
    _ ->
        Nothing

toList : Int -> List Allergy
toList score =
  [ 1, 2, 4, 8, 16, 32, 64, 128 ]
  |> List.filterMap ( \allergenInt -> intToAllergen (Bitwise.and score allergenInt))

isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
  toList score |> List.member allergy
```

## In this approach

This approach uses case expressions to represent a bit mask for the allergy.

A hard coded list of all the possible allergy values is created.
[`List.filterMap`][list-filter-map] is used to filter and map the list.
It converts the allergy values to their matching `Allergy` or filters them out by returning `Nothing`.

You can see a variation of [a Bitwise and case expression solution on Exercism][bitwise-and-case-solution].

## When to use this approach?

This is not as concise as some other solutions, but the code is all very simple and easy to read.
It is the fastest solution of the different approaches.

This approach is better at embracing the concept of using bit positions in the allergy score to represent a list of `Allergy`, using the bit masks.

The bit masks (1, 2, 4 ...) are duplicated once, which most people would say is Ok (people commonly refactor code when it is duplicated 3 times or more).

`toList` is fast, iterating the `allergies` just once, or O(n).
You can add an inverse of the `intToAllergen` function and use it in `isAllergicTo`, which would make the function as fast as it can be (O(1)).
However, this results in another duplication of the allergy values (1, 2, 4, ...).
Optimising for speed usually means unoptimising something else.

The compiler does not guarantee that the `intToAllergen` function or the hard coded list of allergy values contains all the possible values.

This approach does not guarantee that all bit masks are valid, although you could use [`List.range`][list-range] and [`List.map`][list-map] to improve this.

This approach doesn't guarantee that all bit masks are sequential.
This is potentially useful, and means that if there was ever a need for non sequential bit positions, we could support it, but it does also make it easier to make a mistake if the bit positions are required to be sequential.

[list-filter-map]:
  https://package.elm-lang.org/packages/elm/core/latest/List#filterMap
  "List.filterMap documentation"
[list-range]:
  https://package.elm-lang.org/packages/elm/core/latest/List#range
  "List.range documentation"
[list-map]:
  https://package.elm-lang.org/packages/elm/core/latest/List#map
  "List.map documentation"
[bitwise-and-case-solution]:
  https://exercism.org/tracks/elm/exercises/allergies/solutions/jiegillet
  "Bitwise and List solution on exercism"
