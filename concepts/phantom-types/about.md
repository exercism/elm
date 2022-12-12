# About

Elm types allow generic types, that generally add flexibility to an interface.
For example, the type `Maybe a` can hold a value of any type.

```elm
type Maybe a = Nothing | Just a
```

Note that on the example above, the type parameter `a` is used on both sides of the equal sign `=`.
We say that `a` is bound to some data inside the type definition.

## The phantom type technique

In certain cases however, the type parameter only appears on the left side of the equation.

```elm
type Distance unit = Distance Float
```

In the definition of `Distance` above, `unit` is a free type parameter, not bound to any data in the type.
We can also call this type a **phantom type**.

It is surprisingly useful when we want to enforce constraints at compile time.
For example, we want to make sure that we only add distances of the same unit.

```elm
-- Distance is an opaque type, since the module does not expose its variants.
-- This means that users may only use the functions meter, foot and add to manipulate distances.
module Distance exposing (Distance, Meter, Foot, meter, foot, add)

-- The Distance type has a phantom type 'unit'.
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
add (Distance d1) (Distance d2) = Distance (d1 + d2)
```

Code outside of that module cannot access the internal of the `Distance` type.
Users can add two `Distance Meter` but cannot add a `Distance Meter` with a `Distance Foot`.

```elm
import Distance exposing (Distance)

-- Compiles
twoMeters = Distance.add Distance.meter Distance.meter

-- Does not compile
errDist = Distance.add Distance.meter Distance.foot
```

## Extensible records as phantom types

There is no restriction on which types can be phantom, and record types can be used as well.
Elm records are [extensible][extensible-records], which means they may contain more fields than they declare.
When used as phantom types, records are able to express complex constraints that can transform through functions.

Let's add a new distance unit inside of the `Distance` module called `LegoBlock`.
Any `LegoBlock` distance is possible, but we are particularly interested in values that have two properties: being non-fractional and non-negative, as they refer to blocks that exist and are not broken, so we quantify these properties.

```elm
type LegoBlock = LegoBlock

fourStuds : Distance { properties | unit: LegoBlock, nonFractional : (), nonNegative: () }
fourStuds = Distance 4.0

negativeStud : Distance { properties | unit: LegoBlock, nonFractional : () }
negativeStud = Distance -1.0

threeFiddyStud : Distance { properties | unit: LegoBlock, nonNegative : () }
threeFiddyStud = Distance 3.50

crazyStud : Distance { properties | unit: LegoBlock }
crazyStud = Distance -13.37
```

`nonFractional` and `nonNegative` are the fields of a record that doesn't exist outside of types, so it's fitting to give them the type `()`, called the __unit type__, which holds no information beyond the fact that it is there.

Note that all of these values are valid and will compile, we simply have a stronger interest in `fourStuds`, because it is the only one that can be combined with the following function:

```elm
combineLegoBlocks
  :  Distance { properties | unit: LegoBlock, nonFractional : (), nonNegative: () }
  -> Distance { properties | unit: LegoBlock, nonFractional : (), nonNegative: () }
  -> Distance { properties | unit: LegoBlock, nonFractional : (), nonNegative: () }
combineLegoBlocks = add
```

Let's add some functions to let users create and refine `LegoBlock` distances.

```elm
newLegoBlock : Float -> Distance { properties | unit: LegoBlock }
newLegoBlock dist = Distance dist

floorDistance : Distance properties -> Distance { properties | nonFractional : () }
floorDistance (Distance dist) = Distance (toFloat (floor dist))

absDistance : Distance properties -> Distance { properties | nonNegative : () }
absDistance (Distance dist) = Distance (abs dist)
```

Note that `floorDistance` and `absDistance` can handle unit other than `LegoBlock`, and in general do not make any assumptions on the input properties, they merely guarantee that the output will have a specific property, respectively `nonFractional` and `nonNegative`.

Let's look at some outcomes.

```elm
import Distance exposing (Distance)

-- Compiles
distance1 = combineLegoBlocks fourStuds fourStuds

-- Does not compile
distance2 = combineLegoBlocks fourStuds threeFiddyStud

-- Compiles
distance3 = combineLegoBlocks fourStuds (floorDistance threeFiddyStud)

-- Does not compile
distance4 = combineLegoBlocks fourStuds negativeStud

-- Compiles
distance5 = combineLegoBlocks fourStuds (absDistance negativeStud)

-- Does not compile
distance6 = combineLegoBlocks fourStuds crazyStud

-- Compiles
distance7 = combineLegoBlocks fourStuds (floorDistance (absDistance crazyStud))

-- Compiles
distance8 = combineLegoBlocks fourStuds (absDistance (floorDistance crazyStud))
```

Note that `distance7` and `distance8` are different value, because the order of application of `floorDistance` and `absDistance` matters.
The API doesn't make a decision on which application order is better, only that `combineLegoBlocks` receives proper values.
This is the strength of this phantom type technique: providing flexible choices while maintaining guarantees.

[extensible-records]: https://ckoster22.medium.com/advanced-types-in-elm-extensible-records-67e9d804030d
