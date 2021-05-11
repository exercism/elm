# Introduction

A [`list`][lists] in Elm is an immutable collection of zero or more values which must all have the same type.

Lists can be defined as follows:

```elm
empty = []
singleValue = [ 5 ]
threeValues = [ "a", "b", "c" ]
```

The most common way to add an element to a list is through the `::` (cons) operator:

```elm
let twoToFour = [2, 3, 4]
let oneToFour = 1 :: twoToFour
-- => [1; 2; 3; 4]
```

List can be appended using the `++` operator or `List.append`:

```elm
[6, 7] ++ [8, 9]           -- => [6, 7, 8, 9]
List.append [6, 7] [8, 9]  -- => [6, 7, 8, 9]
```

Lists are manipulated by functions and operators defined in the [`List` module][list-module].

List can also be processed using [pattern matching](list-destructuring)

```elm
describe list =
    case list of
        [] ->
            "Empty list"

        [ "hello" ] ->
            "Singleton list with: hello"

        x :: xs ->
            "Non-empty list with head: " ++ head

describe []                   -- => "Empty list"
describe [ "hello" ]          -- => "Singleton list with: hello"
describe [ "hello", "world" ] -- => "Non-empty with head: hello"
```

[lists]: https://elmprogramming.com/list.html
[list-module]: https://package.elm-lang.org/packages/elm/core/latest/List
[list-destructuring]: https://www.elm.christmas/2020/8
