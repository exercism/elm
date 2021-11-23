# General

- The let expressions is described in the [Elm lang documentation][let-elm-lang].
- Whitespace is important
- There can only be one expression in the `in` section

This example shows the syntax

```elm
cylinderArea : Float -> Float -> Float
cylinderArea radius height =
    let
        sideArea = 2 * pi * radius * height
        topArea = pi * radius ^2
    in
        sideArea + 2 * topArea
```

[let-elm-lang]: https://elm-lang.org/docs/syntax#let-expressions
