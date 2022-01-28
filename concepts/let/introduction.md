# Introduction

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
