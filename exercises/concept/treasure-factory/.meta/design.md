# Design

## Goal

The Goal is to learn the phantom type technique by creating a module that uses it.

## Learning objectives

The students should be able to
- understand when phantom types are useful
- create phantom types
- create phantom types with extensible records
- understand the constraints on testing (cannot test something doesn't compile, cannot access insides)

## Out of scope

- package design downsides (breaking changes...)

## Concepts

The concept this exercise unlocks is:

- phantom-types

## Prerequisites

- lists
- maybe
- custom-types
- generics
- opaque-types

## Analyzer

Make sure that
- [essential] the type signatures of `makeChest` and `makeTreasureChest` match the ones in the stub (show them in the comment)
- [essential] the type signature of `secureChest` is exactly `Chest treasure constraints -> Maybe (Chest treasure { constraints | securePassword : () })` (don't show it in the comment)
- [essential] the type signature of `uniqueTreasures` is exactly `List (Chest treasure constraints) -> List (Chest treasure { constraints | uniqueTreasure : () })` (don't show it in the comment)

