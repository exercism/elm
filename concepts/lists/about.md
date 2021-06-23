# About

A [`List`][lists] in Elm is an immutable collection of zero or more values of the same type.
As lists are immutable, once a list has been constructed, its value can never change.
Elm lists have a _head_ (the first element) and a _tail_ (everything after the first element).
The tail of a list is itself a list.

Type annotations for lists can be defined as follows

```elm
List String --> a list of String
List Int --> a list of Int
```

Lists can be defined as follows:

```elm
empty : List Char
empty = []

singleValue = [ 5 ] --> List Int
singleValueAlternative = List.singleton 5 --> List Int

threeValues = [ "a", "b", "c" ] --> List String
```

The most common way to add an element to a list is through the `::` (cons) operator:

```elm
twoToFour = [ 2, 3, 4 ]
oneToFour = 1 :: twoToFour --> [1; 2; 3; 4]
```

List can be appended using the `++` operator or `List.append`:

```elm
[ 6, 7 ] ++ [ 8, 9 ]           --> [6, 7, 8, 9]
List.append [ 6, 7 ] [ 8, 9 ]  --> [6, 7, 8, 9]
```

Lists are manipulated by functions and operators defined in the [`List` module][list-module].

```elm
List.length [ 7, 8 ] --> 2
```

Any function/operator that appear to modify a list (such as adding an element), will actually return a new list.
Performance is usually not an issue though, as the implementation of lists prevents unnecessary allocations/copies.

Lists can also be processed using [pattern matching](list-destructuring).

```elm
describe : List String -> String
describe list =
    case list of
        [] ->
            "Empty list"

        [ "hello" ] ->
            "Singleton list with: hello"

        x :: xs ->
            "Non-empty list with head: " ++ head

describe []                   --> "Empty list"
describe [ "hello" ]          --> "Singleton list with: hello"
describe [ "hello", "world" ] --> "Non-empty list with head: hello"
```

[lists]: https://elmprogramming.com/list.html
[list-module]: https://package.elm-lang.org/packages/elm/core/latest/List
[list-destructuring]: https://www.elm.christmas/2020/8
