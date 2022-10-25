# Introduction

The `Maybe` type is the solution in the Elm language for optional values.
It is thus present in type signatures of a wide number of core Elm functions and understanding it is crucial.
The `Maybe` type is defined as follows:

```elm
type Maybe a = Nothing | Just a
```

This is known as a "custom type" definition in Elm terminology.
It indicates that a value of this type can either be `Nothing` OR be `Just` something of type `a`.
Creating a `Maybe` value is done via one of its two constructors `Nothing` and `Just`.
Reading the content of a `Maybe` is done via pattern matching.

```elm
matthieu : Maybe String
matthieu = Just "Matthieu"

anon : Maybe String
anon = Nothing

sayHello : Maybe String -> String
sayHello maybeName =
    case maybeName of
        Nothing -> "Hello, World!"
        Just someName -> "Hello, " ++ someName ++ "!"

sayHello matthieu
    --> "Hello, Matthieu!"

sayHello anon
    --> "Hello, World!"
```

There are also a number of useful functions in the `Maybe` module to manipulate `Maybe` types.

```elm
sayHelloAgain : Maybe String -> String
sayHelloAgain name = "Hello, " ++ Maybe.withDefault "World" name ++ "!"

capitalizeName : Maybe String -> Maybe String
capitalizeName name = Maybe.map String.toUpper name

capitalizeName matthieu
    --> Just "MATTHIEU"

capitalizeName anon
    --> Nothing
```
