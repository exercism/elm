# Introduction

This exercise is a little contrived, and it doesn't explicity state it, but it is essentially about representing a list of `Allergy`, but using the 0/1 values at the bit positions of an `Int`, instead of using the standard `List` module.

You could imagine that this could be required when interfacing with a legacy system, or to minimise memory usage in a highly constrained environment.

This requires bit manipulation, and in Elm the [`Bitwise` module][bitwise] is the idiomatic way to do bit manipulation.

For all idiomatic solutions, `isAllergicTo` can be defined the same way (shown below), using the result of `toList`.
However, some solutions can define it in a more efficient way.

```elm
isAllergicTo : Allergy -> Int -> Bool
isAllergicTo allergy score =
  toList score |> List.member allergy    
```

To create a power of 2 from a number you can use `Bitwise.shiftLeftBy x 1` or `2 ^ x`. Using `^` is more idiomatic.

## Approach: Bitwise and List

This approach implicitly uses the index of an item in a list to represent the bit position for the allergy.

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
    |> List.filter (\( allergyScore, _ ) -> Bitwise.and allergyScore score > 0 )
    |> List.map Tuple.second
```

This is the example solution, and is concise.

However, the code does not embed the domain concept of using the bit positions in an `Int` to represent a list of `Allergy`.

Also the compiler does not guarantee that the `allergies` list contains all the `Allergy` types.
You can use the [type iterator pattern][type-iterator-pattern] or use the [no missing type constructor][elm-review-no-missing-type-constructor] rule in [Elm Review][elm-review] to fix this.
[Read more about this approach][bitwise-and-list].

## Approach: Bitwise and Dict

This approach uses the key of the Dict to represent the bit position for the allergy.

```elm
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
  Dict.foldr (\key value list -> if Bitwise.and (2 ^ key) score >= 0 then (value :: list) else list) [] allergies
```

This is also concise, and is better at embedding the domain concept of using the bit positions in an `Int` to represent a list of `Allergy` (the bit positions are now explicit).

It is probably more complex, and would take most people longer to write.

Also the compiler does not guarantee that the `allergies` dict contains all the `Allergy` types.
You can use the [type iterator pattern][type-iterator-pattern] to fix this.

[Read more about this approach][bitwise-and-dict].

## Approach: Bitwise and Case expression

This approach uses case expressions to represent a bit mask for the allergy.

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
```

This approach is more lines of code, but they are all simple, and it is faster than the other solutions.

It is better at embedding the domain concept of using the bit positions in an `Int` to represent a list of `Allergy`, using a bit mask instead of a bit position.

The bit masks (1, 2, 4 ...) are duplicated once, which most people would say is Ok (people commonly refactor code when it is duplicated 3 times or more).

The compiler does not guarantee that all `Allergy` types are represented in the case expression.

[Read more about this approach][bitwise-and-case].

## Approach: Bitwise, List and type alias

This approach uses a type alias to represent the bit position and the allergy.

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

This approach at is the best at embedding the domain concept of using the bit positions in an `Int` to represent a list of `Allergy`.
You can also use a tuple instead of a type alias, but then you can't name the variables, so you lose some of this benefit.

The compiler does not guarantee that the `allergies` list contains all the `Allergy` types.
You can use the [type iterator pattern][type-iterator-pattern] to fix this.

[Read more about this approach][bitwise-and-type-alias].

## Other approaches

There are also more esoteric approaches that don't use `Bitwise`, [such as this one using tuples and recursion][esoteric-approach]. `Bitwise` is the idiomatic way to do bit manipulation in Elm, but other solutions can still be interesting to look at.

## Type iterator pattern

In order to allow the compiler to guarantee that all the `Allergy` types are present in the list (or dict or similar), you can use the type iterator pattern, which involves recursion and a case expression.
This is explained in  detail on the [elm patterns website][https://sporto.github.io/elm-patterns/basic/type-iterator.html], and you can see how the code would look for this example below.

```elm
allAllergies : List Allergy
allAllergies =
  let
    next list =
      case head list of
        Nothing -> Eggs :: list |> next
        Just Eggs -> Peanuts :: list |> next
        Just Peanuts -> Shellfish :: list |> next
        Just Shellfish -> Strawberries :: list |> next
        Just Strawberries -> Tomatoes :: list |> next
        Just Tomatoes -> Chocolate :: list |> next
        Just Chocolate -> Pollen :: list |> next
        Just Pollen -> Cats :: list |> next
        Just Cats -> list
  in
  next []
```

## General guidance

The way to determine whether two integers share at leat one `1` bit is to use `Bitwise.and i1 i2 > 0`.
So if you want to see if the first bit is set for an integer you can use `Bitwise.and i 1 > 0`.
If you want to see if the second bit is set for an integer you can use `Bitwise.and i 2 > 0`.
If you want to see if the third bit is set for an integer you can use `Bitwise.and i 4 > 0`.
And so on.

## Which approach to use?

Code exists primarily for humans to read and reason about.
Therefore, in general, go with the approach that _makes the most sense_.

All approaches listed here are valid choices unless marked otherwise.

[bitwise-and]:
  https://package.elm-lang.org/packages/elm/core/latest/Bitwise
  "Bitwise documentation"
[bitwise-and-list]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-list
  "Approach: Bitwise and List"
[bitwise-and-dict]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-dict
  "Approach: Bitwise and Dict"
[embed-domain-concepts]:
  https://www.freecodecamp.org/news/embedding-domain-concepts-in-code/
  "How to embed domain concepts in code"
[type-iterator-pattern]:
  https://sporto.github.io/elm-patterns/basic/type-iterator.html
  "The type iterator pattern"
[elm-review]:
  https://github.com/jfmengels/elm-review
  "Elm Review"
[elm-review-no-missing-type-constructor]:
  https://package.elm-lang.org/packages/Arkham/elm-review-no-missing-type-constructor/latest/
  "No Missing Type Constucture rule for Elm Review
[bitwise-and-case]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-case
  "Approach: Bitwise and case expression"
[bitwise-and-type-alias]:
  https://exercism.org/tracks/elm/exercises/allergies/approaches/bitwise-and-type-alias
  "Approach: Bitwise and type alias"
[esoteric-approach]:
  https://exercism.org/tracks/elm/exercises/allergies/solutions/pwad
  "An esoteric solution to allergies, using recursion, a tuple and a case expression"
