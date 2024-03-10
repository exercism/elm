# Bitwise and Dict

```elm
import Dict exposing (Dict)

allergies : Dict Int Allergy
allergies = 
  Dict.fromList 
    [ (1, Eggs)
    , (2, Peanuts)
    , (3, Shellfish)
    , (4, Strawberries)
    , (5, Tomatoes)
    , (6, Chocolate)
    , (7, Pollen)
    , (8, Cats)
    ]

toList : Int -> List Allergy
toList score =
  Dict.foldr (\key value list -> if Bitwise.and (2 ^ (key - 1)) score > 0 then (value :: list) else list) [] allergies

isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
  toList score |> List.member allergy
```

## In this approach

This approach explicitly uses the key of the Dict to represent the bit position of an `Allergy`.

[`Dict.foldr`][dict-foldr] is used to create a list of `Allergy`, using [`Bitwise.and`][bitwise-and] to match the allergy value with the score.

You can see a variation of [a Bitwise and Dict solution on Exercism][bitwise-and-dict-solution].

## When to use this approach?

This code is idiomatic in Elm and is better at embracing the concept of using bit positions in the allergy score to represent a list of `Allergy`.

`isAllergicTo` is a slightly expensive operation, iterating the `allergies` dict once to make a list, and that list is iterated to match the allergy.
It is faster than the [Bitwise and List approach][bitwise-and-list].
However `allergies` is known and of very small size, so for this exercise we should not try to prematurely optimise.

The compiler does not guarantee that the `allergies` dict contains all the `Allergy` types.
You can use the [type iterator pattern][type-iterator-pattern] to fix this.

This approach does not guarantee that all bit positions are valid.

This approach doesn't guarantee that all bit positions are sequential.
This is potentially useful, and means that if there was ever a need for non sequential bit positions, we could support it, but it does also make it easier to make a mistake if the bit positions are required to be sequential.

[bitwise-and]:
  https://package.elm-lang.org/packages/elm/core/latest/Bitwise#and
  "Bitwise.and documentation"
[type-iterator-pattern]:
  https://sporto.github.io/elm-patterns/basic/type-iterator.html
  "The type iterator pattern"
[dict-foldr]:
  https://package.elm-lang.org/packages/elm/core/latest/Dict#foldr
  "Dict.foldr documentation"
[bitwise-and-list]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-list
  "Approach: Bitwise and List"
[bitwise-and-dict-solution]:
  https://exercism.org/tracks/elm/exercises/allergies/solutions/Al38andr0
  "Bitwise and Dict solution on exercism"
