# Tuples

Tuples in Elm can hold two or three values, and each value can have any type.
In Elm, Tuples are mostly used for simple transient types.
For this reason Tuples have a maximum of 3 values, and as a further encouragement convenience functions are only supplied for 2 values.
For more complex data, it is best to switch to records.
A common use is if you need to return more than one value from a function.
Tuple fields don't have names, they are accessed by means of destructuring or by position.

You can read a [concise introduction to tuples][tuples-concise].
There is also a [more in depth introduction][tuples-in-depth], and the [API doc of the Tuple module][tuple-core] contains code examples and detailed documentation.

## Declaration

Types for Tuples are created with parentheses and their element types are separated by commas.

```elm
type alias IntStringTuple = (Int, String)
```

### Creation

Tuples are created with parentheses and their elements are separated by commas.

```elm
aTuple : IntStringTuple
aTuple = (123, "elements can be of differing types")
```

You can also use `Tuple.pair` to create a tuple with two values.

```elm
anotherTuple : (String, String)
anotherTuple = Tuple.pair "this time it's" "two strings"
    --> ("this time it's", "two strings")
```

### Access

There are also functions to access tuple values by position, `Tuple.first` and `Tuple.second`.

```elm
Tuple.first aTuple
    --> 123

Tuple.second aTuple
    --> "elements can be of differing types"
```

Tuples can be _destructured_ in bindings using tuple pattern matching.
Destructuring can be done in let expressions, function declarations and case statements.

```elm
repeatString : (Int, String) -> Bool
repeatString aTuple =
let
    (aNumber, aString) = aTuple
in
    String.repeat aNumber aString

repeatStringAgain : (Int, String) -> Bool
repeatStringAgain (aNumber, aString) = String.repeat aNumber aString
```

Pattern matching in a case statement also allows you to match on content of the values:

```elm
has123 : (Int, String, Bool) -> Bool
has123 aTuple =
    case aTuple of
        (123, _, _) ->
            True
        (_, "123", _) ->
            True
        (_, _, True) ->
            True
        _ ->
            False
```

[tuples-concise]: https://www.bekk.christmas/post/2020/1/once-twice-three-times-a-value
[tuples-in-depth]: https://elmprogramming.com/tuple.html
[tuple-core]: https://package.elm-lang.org/packages/elm/core/latest/Tuple
