# About

## Introduction

Generics are a language feature that enable code reuse.
For example, it should not matter what type a list holds in order to compute its length.
That is why the `length` function uses a generic type parameter `a` in its type signature.

```elm
length : List a -> Int
```

## Parameters in types

When a type is generic over another type, we use a lowercase name for that other type, and call it a type parameter.
Common examples are the `List`, `Maybe` and `Result` custom types.

```elm
-- Maybe is generic over the type a
type Maybe a
    = Nothing
    | Just a

someString : Maybe String
someString = Just "hello"

someInt : Maybe Int
someInt = Just 42
```

A type can be generic over multiple other types, and thus have multiple type parameters.
In that case, every independent type gets a different lowercase name.
Being independent does not prevent them from becoming the same type, it just enables them to be different.

```elm
-- Result is generic over the types error and value
type Result error value
    = Ok value
    | Err error
```

Record type alias' can also have type parameters, although it is less common.

```elm
-- Event is generic over the type a
type alias Event a =
    { at : Time
    , data : a 
    }
```

One important remark about names of type parameters, is that they can be multiple characters long.
The only constraint is that they must be lowercase names.
As such, when useful, we tend to give them descriptive names.

> This is why the `Html` package defines the `Html msg` type, with one type parameter named `msg`.
> The Elm architecture guides you towards creation of a custom type `Msg` describing all messages that your web page can trigger.
> As a result, your code will be building views of the type `Html Msg` where `Msg` is the concrete type that you defined.
> Beginners are sometimes confused between errors mentioning `Html msg` (lowercase) and errors with `Html Msg`.
> Now you know!
> The difference is that the first one is generic over any `msg` type, while the second is specific to your `Msg` type.

## Type parameters in functions

Since types can be generic, so can functions.
Functions handling generic types can be writen, such as the `Maybe.withDefault`.

```elm
withDefault : a -> Maybe a -> a
withDefault default maybe =
    case maybe of
      Just value -> value
      Nothing -> default
```

Functions can take other functions as parameters, and these can also be generic
Functions that take other functions as parameters are called higher order functions.

```elm
map : (a -> b) -> Maybe a -> Maybe b
map function maybe =
  case maybe of
    Just value ->
      Just (function value)

    Nothing ->
      Nothing
```

Type parameters can appear both in the inputs and in the output of a function, and genericity enabled by type parameters is usually called **parametric polymorphism**.
This is in contrast with ad hoc polymorphism also known as function overloading, where the same function name can be used on multiple implementation where the types differ.
This also contrasts with subtype polymorphism, where types can be defined in a hierarchy, and functions defined on a type can also be called with arguments of its subtypes.
In Elm, the only available mechanism for genericity is parametric polymorphism.
