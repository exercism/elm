# Bitwise, List and type alias

```elm
type alias AllergyAndScore = {
  allergy: Allergy;
  bitPosition: Int;
}

allergiesAndScores : List AllergyAndScore
allergiesAndScores =
    [ AllergyAndScore Eggs 1
    , AllergyAndScore Peanuts 2
    , AllergyAndScore Shellfish 3
    , AllergyAndScore Strawberries 4
    , AllergyAndScore Tomatoes 5
    , AllergyAndScore Chocolate 6
    , AllergyAndScore Pollen 7
    , AllergyAndScore Cats 8
    ]

toList : Int -> List Allergy
toList score =
  allergiesAndScores
    |> List.Map (\allergyAndScore -> ( 2 ^ allergyAndScore.bitPosition, allergyAndScore.allergy ))
    |> List.filter (\( s, _ ) -> Bitwise.and s score > 0)
    |> List.map Tuple.second
```

## In this approach

This approach uses a type alias to represent the bit position and the allergy.

The approach is very similar to the [Bitwise and List approach][bitwise-and-list], but uses a type alias to make the bit position explicit. It could instead be based on the [Bitwise and Dict approach][bitwise-and-dict].

## When to use this approach?

This approach makes the domain concept of using bit positions in an `Int` to represent a list of `Allergy` more explicit, and is the best approach for this, but otherwise shares most of the same properties as the [Bitwise and List approach][bitwise-and-list] it is based on.

The only difference is that the bit positions are hard coded and explicit.

This means that this approach does not guarantee that all bit positions are valid.

It also means that this approach doesn't guarantee that all bit positions are sequential.
This is potentially useful, and means that if there was ever a need for non sequential bit positions, we could support it, but it does also make it easier to make a mistake if the bit positions are required to be sequential.

[bitwise-and-list]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-list
  "Approach: Bitwise and List"
[bitwise-and-dict]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-dict
  "Approach: Bitwise and Dict"
