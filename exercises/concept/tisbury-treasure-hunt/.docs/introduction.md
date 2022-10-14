# Introduction

## Tuples

Tuples in Elm can hold two or three values, and each value can have any type.
In Elm, Tuples are mostly used for simple transient types.
For this reason Tuples have a maximum of 3 values, and as a further encouragement convenience functions are only supplied for 2 values.
For more complex data, it is best to switch to records.

```elm
type alias IntStringTuple = (Int, String)

aTuple : IntStringTuple
aTuple = (123, "elements can be of differing types")

anotherTuple : (String, String)
anotherTuple = Tuple.pair "this time it's" "two strings"
    --> ("this time it's", "two strings")

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
