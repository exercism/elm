# Introduction

Generics are a way of writing code that avoid duplications of code.
For example, it should not matter what type a list holds in order to compute its length.
That is why that function uses a generic type parameter `a` in its type signature.

```elm
length : List a -> Int
```

## Type parameters in types

When a type is generic over another type, we use a lowercase name for that other type, and call it a type parameter.
Two very common examples are the `List` and `Maybe` types.

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
In that case, every independant type gets a different lowercase name.
Being independant does not prevent them from becoming the same type, it just enables them to be different.

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

One important remark about names of type parameters, is that they can be multiple characters long.
The only constraint is that they must be lowercase names.
As such, when useful, we tend to give them descriptive names.

> This is why the `Html` package defines the `Html msg` type, with one type parameter named `msg`.
> The elm architecture guides you towards creation of a custom type `Msg` describing all messages that your web page can trigger.
> As a result, your code will be building views of the type `Html Msg` where `Msg` is the concrete type that you defined.
> Newcommers are sometimes confused between errors mentioning `Html msg` (lowercase) and errors with `Html Msg`.
> Now you know!
> The difference is that the first one is generic over any `msg` type, while the second is specific to your `Msg` type.

## Type parameters in functions

Since types can be generic, so can functions.
Functions handling generic types can be writen, such as the `List.length` function that we mentioned at the beginning.

```elm
length : List a -> Int
length list =
    case list of
        [] ->
            0
        _ :: restOfTheList ->
            1 + length restOfTheList
```

Type parameters can appear both in the inputs and in the output of a function, and genericity enabled by type parameters is usually called **parametric polymorphism**.
This is in contrast with ad hoc polymorphism also known as function overloading, where the same function name can be used on multiple implementation where the types differ.
This also contrasts with subtype polymorphism, where types can be defined in a hierarchy, and functions defined on a type can also be called with arguments of its subtypes.
In elm, the only available mechanism for genericity is parametric polymorphism.

## Enforcing compile-time constraints with phantom types

In most cases, type parameters are introduced to enable genericity.
This is what happens when the type parameter is present on both sides of the equal sign `=` in the type definition, as in our `Maybe` definition.

```elm
-- the type parameter 'a' is present both on the left side
-- and on the right side of the equal sign '='.
type Maybe a = Nothing | Just a
```

We say that the type parameter `a` is bound to some data inside the type definition.
In certain cases however, the type parameter only appears on the left side of the equation.

```elm
type Distance unit = Distance Float
```

In the definition of `Distance` above, `unit` is a free type parameter, not bound to any data in the type.
We can also call this technique **phantom types**.
It is surprisingly useful when we want to enforce constraints at compile type.
For example, we want to make sure that we only add distances of the same unit.

```elm
-- The module does not expose the internals of Distance,
-- but instead two constructor functions: meter and foot.
-- We do not want to expose 'Distance(..)' because we do not want
-- people outside this module to access the internals of Distance.
module Distance exposing (Distance, Meter, Foot, meter, foot, add)

-- The Distance type has a phantom type 'unit'
type Distance unit = Distance Float

-- We define two types that will be used in place
-- of the phantom type 'unit' in our constructor functions.
type Meter = Meter
type Foot = Foot

-- Constructor for Meter
meter : Distance Meter
meter = Distance 1.0

-- Constructor for Foot
foot : Distance Foot
foot = Distance 0.3048

-- The add function cannot take two parameters of different types.
-- So we cannot add meters and feet by mistake.
add : Distance unit -> Distance unit -> Distance unit
add (Distance d1) (Distance d2) =
    Distance (d1 + d2)
```

All code outside of that module cannot access the internal of the `Distance` type.
So we can add two `Distance Meter` but cannot add a `Distance Meter` with a `Distance Foot`.

```elm
import Distance exposing (Distance)

-- This compiles OK
twoMeters = Distance.add Distance.meter Distance.meter

-- This fails at compile time
errDist = Distance.add Distance.meter Distance.foot
```

## Higher order functions

- basics of higher order functions: dependency injection.
- passing functions in config.
- common patterns accross container types (map, andThen, etc.)
