# Introduction

The `Maybe` type is the solution in the Elm language for optional values.
It is thus present in type signatures of a wide number of core Elm functions and understanding it is crucial.

## Definition and type variable

The `Maybe` type is defined as follows:

```elm
type Maybe a = Nothing | Just a
```

This is know as a "custom type" definition in Elm terminology.
Custom types are introduced in details in another concept of this track but we won't need it to understand specifically `Maybe`.
The `a` in `Maybe a` and `Just a` represents a type variable, meaning it can be any type, such as `Int`, `Bool` or `String`.
As such, a `Maybe String` is a variable that optionally holds a `String`, while a `Maybe Int` would optionally hold an `Int`.

```elm
name : Maybe String
name = Just "Matthieu"

age : Maybe Int
age = Just 29
```

The vertical bar `|` in the type definition of `Maybe` means "OR".
It indicates that it can either be `Nothing` OR be `Just` something.
So imagine that the name and age were not filled by that person, we would have the following.

```elm
name : Maybe String
name = Nothing

age : Maybe Int
age = Nothing
```

## Reading the content a Maybe value

Reading the content of a `Maybe` value is done via "pattern matching".
Pattern matching is also introduced in more details in another concept, so we just focus on how pattern matching a `Maybe` works.

```elm
-- This function returns "Hello, <name>!" if the name was provided.
-- Otherwise, it just says "Hello, World!".
sayHello : Maybe String -> String
sayHello maybeName =
    case maybeName of
        Nothing -> "Hello, World!"
        Just someName -> "Hello, " ++ someName ++ "!"

sayHello (Just "Matthieu")
    --> "Hello, Matthieu!"

sayHello Nothing
    --> "Hello, World!"
```

Everytime you use a `Maybe` value, the Elm compiler will check that your code handles all possibilities so you can never pattern match a `Maybe` and only handle the case where there is a `Just someValue`.
This may seem anoying at first, but it is one of the greatest strengths of the Elm language.
This will prevent hundreds of bugs and makes compiler-guided refactoring a fearless and rewarding experience.
