# About

[Custom Types][custom-types] in Elm represent a fixed number of named cases. Each value corresponds to exactly one of the named cases. In other languages / contexts these are known as _sum types_, _discriminated unions_, _tagged unions_ and _algebraic data types_.

Each case of a discriminated union can optionally have data associated with it, and different cases can have different types of data. If none of the cases have data associated with them, the discriminated union is similar to what other languages usually refer to as an _enumeration_ (or _enum_).

A Custom Type is defined using the `type` keyword and requires very little syntax. They are one of the most important techniques in Elm programming, and are used to make the possible values in code exactly match the valid values in real life, which leaves no room for invalid data, and makes [impossible states impossible to represent in the code][impossible-states].

```elm
-- Custom Type without associated data
type Season
    = Spring
    | Summer
    | Autumn
    | Winter

-- Custom Type with associated data
type FlexibleNumber
    = Integer Int
    | Float Float
    | Invalid
```

Creating a value for a specific case can be done by referring to its name (`Spring`), when it is defined in the same module, or is imported with the `import SeasonModule exposing (Season(..))` style syntax, or by referring to its fully qualified name (`Season.Spring`) when imported with `import SeasonModule exposing (Season)` style syntax.

```elm
integerTwo = Integer 2
invalid = FlexibleNumber.Invalid
```

Custom types, along with everything in Elm, have _structural equality_, which means that two values for the same case and with the same (optional) data are equivalent.

The preferred way to work with custom types is with [pattern matching][pattern-matching]:

```elm
let describe flexibleNumber =
    case flexibleNumber of
        Integer i ->
            "Integer: " ++ fromInt(i)

        Float f ->
            "Float: " ++ fromFloat(f)

        Invalid   ->
            "Invalid"
```

[custom-types]: https://elmprogramming.com/type-system.html#creating-our-own-types
[pattern-matching]: https://guide.elm-lang.org/types/pattern_matching.html
[impossible-states]: https://www.youtube.com/watch?v=IcgmSRJHu_8
