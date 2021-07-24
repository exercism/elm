# Introduction

Generics are a way of writing code that avoid duplications of code.
For example, it should not matter what type a list holds in order to compute its length.
That is why that function uses a generic type parameter `a` in its type signature.

```elm
length : List a -> Int
```

## Type parameters in types

- single type parameter used once
- single type parameter used multiple times
- multiple type parameters

## Type parameters in functions

- as input
- as output
- as both input and output
- parametric polymorphism VS ad hoc polymorphism VS subtyping polymorphism

## Higher order functions

- basics of higher order functions: dependency injection.
- common patterns accross container types (map, andThen, etc.)
