# Introduction

## Comparison

### Equality

Elm types can be checked for "being the same" with the equality operator `(==)`.
The inequality operator is `(/=)` (*not* `!=` like in many languages).
The equality operator works on literals, tuples, records and custom types.

```elm
1 == 2
    --> False

1 /= 2
    --> True

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

### Comparisons

The comparison operators `(<)`, `(<=)`, `(>)`, `(>=)` and functions `min`, `max`, `compare` work on `comparable` types.
The `comparable` type is a special type that groups all built-in types that can be compared: numbers, characters, strings, lists of comparable things, and tuples of comparable things.

```elm
1 < 1 + 1
    --> True

'x' < 'X'
    --> False

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
```

Values of other types such as records or custom types cannot be compared directly.

Some built-in types require their content to be `comparable`, such as `Set` or `Dict` keys, since their structure relies on an internal ordering.

Lists of `comparable` values can be sorted with `List.sort` and lists of values that can be mapped to comparable values can be sorted with `List.sortBy`.
If you need a hierarchical sort (sort by one property, and break ties with another), tuples or lists may also be used with `List.sortBy` since tuples and lists are sorted in lexicographic order.


```elm
List.sort ["hi", "hello", "bye", "goodbye"]
    --> ["bye", "goodbye", "hello", "hi"]

List.sortBy String.length ["hi", "hello", "bye", "goodbye"]
    --> ["hi", "bye", "hello", "goodbye"]

-- sort by length, then alphabetically
List.sortBy (\str -> (String.length str, str)) ["hi", "mum", "hello", "sis", "bye", "dad"]
    --> ["hi", "bye", "dad", "mum", "sis", "hello"]
```

The function `compare` takes two `comparable` values and returns an `Order`.
An `Order` is a type that checks in a in a single operation if a value is greater (`GT`), equal (`EQ`) or less (`LT`) than another.

```elm
compare 1 2
    --> LT

compare "" ""
    --> EQ

compare [12] []
    --> GT
```

Comparison functions can be constructed for arbitrary types and be used, for example, to be sorted with `List.sortWith`:

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
