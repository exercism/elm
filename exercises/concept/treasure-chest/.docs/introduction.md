# Introduction

## Generics

### Introduction

Generics are a language feature that enable code reuse.
For example, it should not matter what type a list holds in order to compute its length.
That is why the `length` function uses a generic type parameter `a` in its type signature.

```elm
length : List a -> Int
```

### Parameters in types

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

One important remark about names of type parameters, is that they can be multiple characters long.
The only constraint is that they must be lowercase names.
As such, when useful, we tend to give them descriptive names.

A type can be generic over multiple other types, and thus have multiple type parameters.
In that case, every independent type gets a different lowercase name.
Being independent does not prevent them from becoming the same type, it just enables them to be different.

```elm
-- Result is generic over the types error and value
type Result error value
    = Ok value
    | Err error
```

Record type aliases can also have type parameters, although it is less common.

```elm
-- Event is generic over the type a
type alias Event a =
    { at : Time
    , data : a 
    }
```

### Type parameters in functions

Since types can be generic, so can functions.
Functions handling generic types can be writen, such as the `Maybe.withDefault`.

```elm
withDefault : a -> Maybe a -> a
withDefault default maybe =
    case maybe of
      Just value -> value
      Nothing -> default
```

Functions that take other functions as parameters are called higher order functions, and these can also be generic.

```elm
map : (a -> b) -> Maybe a -> Maybe b
map function maybe =
  case maybe of
    Just value ->
      Just (function value)

    Nothing ->
      Nothing
```
