# Design

## Goal

The Goal is to learn to use tail call recursion

## Learning objectives

Students should be able to

- understand what tail-call recursion is
- understand that Elm optimizes tail-call recursive functions
- remember that there are caveats to the optimization
- write a tail-call recursive function

## Out of scope

Nothing

## Concepts

The concept this exercise unlocks is:

- `tail-call-recursion`

## Prerequisites

- `recursion`

## Analyzer

- [essential] all functions are implemented with recursion
- [essential] all recursive function are tail call recursive
- [essential] the `List` module is not used
- [actionable] `pipersPi` should not call `factorial` or `doubleFactorial`, suggest to build terms iteratively instead
