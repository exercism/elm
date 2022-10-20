# About

## Equality

Elm types can be checked for "being the same" with the [equality operator][equality-operator] `(==)`.
The inequality operator is `(/=)` (*not* `!=` like in many languages).

```elm
1 == 2
    --> False

1 /= 2
    --> True
```

Both values being compared have to be of thew same type.
The equality operator works on literals, tuples, records and custom types.
The operator checks for structural equality, which means that equal values have equal content and deep structure, regardless of type annotation or position in memory.

```elm
(1, 2) == (2, 1)
    --> False

type alias MyRecord = { myInt : Int, myStrings : List String }
a : MyRecord
a = MyRecord (1 + 1) ["hello world"]

type alias MyOtherRecord = { myInt : Int, myStrings : List String }
myStrings =  (String.join " " ["hello", "world"]) :: []
b : MyOtherRecord
b = { myInt = 2, myStrings = myStrings}

a == b
    --> True
```

Note that you *should never* compare functions, as this will make the program crash at runtime.
More information about that limitation [here][equality-operator].

## Comparisons

The [comparison operators][comparison-operators] `(<)`, `(<=)`, `(>)`, `(>=)` and functions `min`, `max`, `compare` work on `comparable` types.
The `comparable` type is a special type that groups all built-in types that can be compared: numbers, characters, strings, lists of comparable things, and tuples of comparable things.
Characters are compared from their [unicode codepoints][unicode-codepoint].

```elm
1 < 1 + 1
    --> True

'x' < 'X'
    --> False

'互' < '🙏'
    --> True
```

Sequence-like types (strings, lists and tuples) are compared in [lexicographic order][lexicographic-order].
In a nutshell, sequence element are compared pairwise in order until an element is found smaller or a sequence ends.

```elm
"abc" < "abz"
    --> True

"abc" < "abcd"
    --> True

"abc" < "b"
    --> True

min [1 , 2, 9000] [10]
    --> [1 , 2, 9000]

min (1, "hello") (3, "bye")
    --> (1, "hello")

min (1, ['a', 'b']) (1, ['A', 'B'])
    --> (1, ['A', 'B'])
```

Values of other types such as records or custom types cannot be compared directly.

Some built-in types require their content to be `comparable`, such as `Set` or `Dict` keys, since their structure relies on an internal ordering.
That implies that custom types may not be stored in a `Set`, although there are community [alternatives][sort-by]: [`AnySet`][any-set], [`AnyDict`][any-dict], [`Sort`][sort]...

Lists of `comparable` values can be sorted with `List.sort` and lists of values that can be mapped to comparable values can be sorted with `List.sortBy`:

```elm
List.sort ["hi", "hello", "bye", "goodbye"]
    --> ["bye", "goodbye", "hello", "hi"]

List.sortBy String.length ["hi", "hello", "bye", "goodbye"]
    --> ["hi", "bye", "hello", "goodbye"]
```

The function `compare` takes to `comparable` values and returns an `Order` (either less than `LT`, equal `EQ` or greater than `GT`).

```elm
compare 1 2
    --> LT

compare "" ""
    --> EQ

compare [12] []
    --> GT
```

Lists of values that can be compared can be sorted with `List.sortWith`:

```elm
type Color = Red | Green | Blue

compareColors : Color -> Color -> Order
compareColors a b =
  case (a, b) of
    (Red, Red) -> EQ
    (Red, _) -> LT
    (_, Red) -> GT
    (Green, Green) -> EQ
    (Green, _) -> LT
    (_, Green) -> GT
    (Blue, Blue) -> EQ

List.sortWith compareColors [Blue, Red, Green, Green, Blue]
    --> [Red, Green, Green, Blue, Blue]
```

[equality-operator]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(==)
[comparison-operators]: https://package.elm-lang.org/packages/elm/core/latest/Basics#(%3C)
[unicode-codepoint]: https://en.wikipedia.org/wiki/Unicode#Architecture_and_terminology
[lexicographic-order]: https://en.wikipedia.org/wiki/Lexicographic_order
[sort-by]: https://github.com/ceddlyburge/elm-league-tables-from-google-sheets/blob/master/src/Calculations/SortBy.elm
[any-set]: https://package.elm-lang.org/packages/turboMaCk/any-set/latest/
[any-dict]: https://package.elm-lang.org/packages/turboMaCk/any-dict/latest/
[sort]: https://package.elm-lang.org/packages/rtfeldman/elm-sorter-experiment/latest/Sort
