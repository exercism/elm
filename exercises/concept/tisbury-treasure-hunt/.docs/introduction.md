# Tuples

Tuples in Elm can hold two or three values, and each value can have any type, although idiomatically the two value tuple is most commonly used.
A common use is if you need to return more than one value from a function.
A tuple's fields don't have names, they are accessed by means of destructuring or by position.

You can read a [concise introduction to tuples][tuples-concise].
There is also a [more in depth introduction][tuples-in-depth], and the [core/Tuple][tuple-core] package contains some of the source code and documentation.

## Declaration

Types for Tuples are created with parentheses and their element types are separated by commas.

```elm
type alias IntStringTuple = (Int, String)
```

### Creation

Tuples are created with parentheses and their elements are separated by commas.

```elm
aTuple = (123, "elements can be of differing types")
```

You can also use `Tuple.pair` to create a tuple with two values.

```elm
aTuple = Tuple.pair 123 "elements can be of differing types"
--> (123, "elements can be of differing types")
```

### Access

Tuples can be _destructured_ in bindings using tuple pattern matching.
Destructuring can be done in let expressions, function declarations and case statements.

```elm
doSomethingWith: (Int, String) -> Bool
doSomethingWith aTuple =
let
    (aNumber, aString) = aTuple
in
...
```

```elm
doSomethingWith: (Int, String) -> Bool
doSomethingWith (aNumber, aString) =
    ...
```

Pattern matching in a case statement also allows you to match on content of the values:

```elm
doSomethingWith: (Int, String) -> Bool
doSomethingWith aTuple =
    case aTuple of
        (123, _) ->
            True
        (_, "123") ->
            True
        (aNumber, aString) ->
            ...
```

There are also functions to access tuple values by position, `Tuple.first` and `Tuple.second`.

```elm
doSomethingWith: (Int, String) -> Bool
doSomethingWith aTuple =
    let
        aNumber = Tuple.first aTuple
        aString = Tuple.sceond aTuple
    in
    ...
```

[tuples-concise]: https://www.elm.christmas/2020/1
[tuples-in-depth]: https://elmprogramming.com/tuple.html
[tuple-core]: https://package.elm-lang.org/packages/elm/core/latest/Tuple
