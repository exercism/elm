# Introduction

Generics are a way of writing code that avoid duplications of code.
For example, it should not matter what type a list holds in order to compute its length.
That is why that function uses a generic type parameter `a` in its type signature.

```elm
length : List a -> Int
```

## Type parameters in types

When a type is generic over another type, we use a lowercase name for that other type.
Two very common examples are the `List` and `Maybe` types.

```elm
-- Maybe is generic regarding the type a
type Maybe a
    = Nothing
    | Just a

someString : Maybe String
someString = Just "hello"

someInt : Maybe Int
someInt = Just 42
```

A type can be generic over multiple other types.
In that case, every independant type gets a different lowercase name.
Being independant does not prevent them from being the same, it just enables them to be different.

```elm
type alias NamedPair a b =
    { first : a
    , second : b
    }

person : NamedPair String Int
person = { first = "Jane", second = 18 }

coordinates : NamedPair Int Int
coordinates = { first = -3, second = 15 }
```

## Type parameters in functions

- as input
- as output
- as both input and output
- parametric polymorphism VS ad hoc polymorphism VS subtyping polymorphism

## Higher order functions

- basics of higher order functions: dependency injection.
- common patterns accross container types (map, andThen, etc.)
