# Introduction

A [`List`][lists] in Elm is an immutable collection of zero or more values of the same type.

Lists can be defined as follows:

```elm
empty = []
singleValue = [ 5 ]
threeValues = [ "a", "b", "c" ]
```

The most common way to add an element to a list is through the `::` (cons) operator:

```elm
twoToFour = [ 2, 3, 4 ]
oneToFour = 1 :: twoToFour --> [ 1, 2, 3, 4 ]
```

Lists are manipulated by functions and operators defined in the [`List` module][list-module] or by [pattern matching](list-destructuring)

```elm
describe : List String -> String
describe list =
    case list of
        [] ->
            "Empty list"

        [ "hello" ] ->
            "Singleton list with: hello"

        x :: xs ->
            "Non-empty list with head: " ++ x

describe []                   --> "Empty list"
describe [ "hello" ]          --> "Singleton list with: hello"
describe [ "hello", "world" ] --> "Non-empty list with head: hello"
```

[lists]: https://elmprogramming.com/list.html
[list-module]: https://package.elm-lang.org/packages/elm/core/latest/List
[list-destructuring]: https://www.bekk.christmas/post/2020/8/peeking-inside-lists
