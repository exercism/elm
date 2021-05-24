# About

[Records][records] are labeled data structures that permit lightweight representations of complex data. The overall goal of records is to organize related data in a way that is super easy to access and update. They kind of fill the role of objects in JavaScript or Java, but with some key distinctions.

Elm also supports [structural typing][structural-typing] meaning that if a function requires a record with an x and y field, it will work with any record that has those fields (2D points, 3D points, spaceships, etc.).

Records are [created][create] with curly brackets and their elements are separated by commas.

```elm
    { name = "Firefly"
    , creator = "Joss Whedon"
    , episodes = 14 }
```

The type of a record is also defined with similar syntax

```elm
    { name : String
    , creator : String
    , episodes : Int }
```

Repeating these type definitions is cumbersome, so using a [type alias][record-types] to share the definition is a common idiom.

```elm
    type alias TvSeries =
    { name : String
    , creator : String
    , episodes : Int }
```

The type alias also supplies a constructor for the record

```elm
    TvSeries "Firefly" "Joss Whedon" 14
    -- =>
    -- { name : String
    -- , creator : String
    -- , episodes : Int }
```

To [access a record instance's field values][access], dot-notation on the record can be used. The Elm compiler also supports special accessor functions, such as `.creator`, which is a function that takes a record and returns the `creator` field from it. This works for any record that has a field of the relevant name, and can be useful for passing to other functions.

```elm
  let
    firefly = TvSeries "Firefly" "Joss Whedon" 14
  in
  Debug.log "name" firefly.name -- => "Firefly"
  Debug.log "creator" (.creator firefly) -- => "Joss Whedon"
```

As records are immutable, once a record has been constructed, its field values can never change. There is a [special syntax to create a copy of an existing record, but with new values for one or more fields][update].

```elm
    let
      firefly = TvSeries "Firefly" "Joss Whedon" 14
    in
    { firefly | creator = "J Whedon", episodes = 15 }
    -- =>
    -- { name : "Firefly"
    -- , creator : "J Whedon"
    -- , episodes : 15 }
```

Elm uses [structural equality][equality], which means that two instances of the same record with identical values are equivalent:

```elm
let
  firefly1 = TvSeries "Firefly" "Joss Whedon" 14
  firefly2 = TvSeries "Firefly" "Joss Whedon" 14
in
firefly1 == firefly2 -- => True
```

Besides being able to use dot-notation to access a record's fields, records can also be _deconstructed_ in bindings and in pattern matching using the [record pattern][record-patterns]. Pattern matching works with any record that has fields of the relevant names.

```elm
let
  firefly = TvSeries "Firefly" "Joss Whedon" 14
  { name, episodes } = firefly
in
  Debug.log "name" name -- => "Firefly"
  Debug.log "episodes" episodes -- => 14
```

[records]: https://elm-lang.org/docs/records
[record-types]: https://elm-lang.org/docs/records#record-types
[structural-typing]: https://en.wikipedia.org/wiki/Structural_type_system
[create]: https://elm-lang.org/docs/records#what-is-a-record-
[update]: https://elm-lang.org/docs/records#updating-records
[access]: https://elm-lang.org/docs/records#access
[pattern-matching]: https://elm-lang.org/docs/records#pattern-matching
