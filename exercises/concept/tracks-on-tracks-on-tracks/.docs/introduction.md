# Introduction

A `List` in Elm is an immutable collection of zero or more values of the same type.
As lists are immutable, once a list has been constructed, its value can never change.
Any functions/operators that appear to modify a list (such as adding an element), will actually return a new list.

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

Elm list's have a _head_ (the first element) and a _tail_ (everything after the first element).
The tail of a list is itself a list.
Lists are either manipulated by functions and operators defined in the `List` module, or manually using pattern matching.

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
