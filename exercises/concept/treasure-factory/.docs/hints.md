# Hints

## General

- Watch Jeroen Engels' [excellent talk][phantom-builder-pattern] on the phantom builder pattern

## 1. Provide a placeholder for treasure chests

- `Chest` can be the same as `TreasureChest`, a single variant with a phantom type added
- The placeholder `Chest todo` doesn't have enough type arguments, it is missing the phantom type
- The phantom type should be a record, so it can be extended
- The start type is the unconstrained `Chest treasure {}` and the final type is the fully vetted `Chest treasure { conditions | securePassword : (), uniqueTreasure : () }`
- To go from the start type to the other, the conditions `securePassword : ()` and `uniqueTreasure : ()` will be added by `secureChest` and `uniqueTreasures` independently

## 2. Select secure chests

- You can pattern match the `Chest` in the function argument
- You can use the function [`String.length`][string-length] to validate the password
- The `securePassword : ()` condition is added from the type signature, not from the function body
- You cannot place an unconstrained `Chest` in a `Just` and expect the type to change. You need to create a new value with the `Chest` constructor

## 3. Select unique treasures

- There is no `List.unique` function you can use, you should create your own
- One possible approach is to use `List.filterMap` with a helper function of type similar to `secureChest`
- The `uniqueTreasure : ()` condition is added from the type signature, not from the function body
- You cannot place an unconstrained `Chest` in a `Just` and expect the type to change. You need to create a new value with the `Chest` constructor

## 4. Enjoy the final product

- `makeTreasureChest` should make use of the `TreasureChest` type constructor


[phantom-builder-pattern]: https://www.youtube.com/watch?v=Trp3tmpMb-o
[string-length]: https://package.elm-lang.org/packages/elm/core/latest/String#length
[filterMap]: https://package.elm-lang.org/packages/elm/core/latest/List#filterMap
