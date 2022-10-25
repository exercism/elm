# Introduction

## Let

The `let` expression is used to create a local scope, and is useful in a few situations:

- For simplifying expressions
- For naming the results of intermediate expressions
- Splitting an expression in to smaller bits if it is getting large

You can do most things inside a `let` expression, including destructuring (more details on this in later exercises), but it isn't possible to define a new Custom Type or Type Alias.

```elm
let
  cube x = x * x * x
in
  cube a + cube b + cube c
```

```elm
beginWithPattern : Size -> Padding -> Pattern -> GameOfLife
beginWithPattern minimumSize padding pattern =
    let
        size = calculateSize minimumSize padding pattern

        center = Size.center size

        centeredPattern = Pattern.centerAt center pattern

        dimensions = { width = size, height = size }

        deadCells = Matrix.create dimensions Dead
    in
    GameOfLife (bringPatternToLife deadCells centeredPattern)
```
