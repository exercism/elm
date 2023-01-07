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
Physical blocks, being regulated objects, always have two properties: they have non-fractional and non-negative distances.

```elm
type LegoBlock = LegoBlock

fourStuds : Distance { properties | unit: LegoBlock, nonFractional : (), nonNegative: () }
fourStuds = Distance 4.0
```

`nonFractional` and `nonNegative` are the fields of a record that doesn't exist outside of a type argument, so it's fitting to give them the type `()`, called the __unit type__, which holds no information beyond the fact that it is there.

Obtaining arbitrary `LegoBlock` distances is of course possible, for example after computing distance differences or ratios.

```elm
negativeStud : Distance { properties | unit: LegoBlock, nonFractional : () }
negativeStud = Distance -1.0

threeFiddyStud : Distance { properties | unit: LegoBlock, nonNegative : () }
threeFiddyStud = Distance 3.50

crazyStud : Distance { properties | unit: LegoBlock }
crazyStud = Distance -13.37
```

All the above values are valid and will compile, however we have a special interest in values like `fourStuds` that have both the `nonFractional` and `nonNegative` properties because they represent physical blocks that can be combined with

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

ceilingDistance : Distance properties -> Distance { properties | nonFractional : () }
ceilingDistance (Distance dist) = Distance (toFloat (ceiling dist))

absDistance : Distance properties -> Distance { properties | nonNegative : () }
absDistance (Distance dist) = Distance (abs dist)
```

Note that `floorDistance`, `ceilingDistance` and `absDistance` can handle unit other than `LegoBlock`, and in general do not make any assumptions on the input properties, they merely guarantee that the output will have a specific property, `nonFractional` or `nonNegative`.

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
distance8 = combineLegoBlocks fourStuds (ceilingDistance (absDistance crazyStud))
```

In general, `floorDistance` and `ceilingDistance` provide different results, but the same guarantees.
This is the strength of the phantom type technique: providing flexible choices to users while maintaining strong guarantees.

[extensible-records]: https://ckoster22.medium.com/advanced-types-in-elm-extensible-records-67e9d804030d
